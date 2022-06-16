
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
var firestore = admin.firestore()
const FieldValue = admin.firestore.FieldValue;
const Timestamp = admin.firestore.Timestamp;


exports.resetMonthCycles = functions.pubsub
    .schedule('0 0 1 * *')
    .onRun(async (context) => {
        const users = await firestore.collection('users').get()
        const toChat = "endcycle";

        for (const userSnapShot of users.docs) {
          const users = firestore.collection('users')
          const budgets = await users.doc(userSnapShot.id).collection('budgets').where('isCycle', '==', true).where( 'cycle', '==', 1).get()
          if (budgets.empty) { return; }

          budgets.forEach(snapshot => {
            const budget = snapshot.data()
            const movements = budget['movements']

            // Se añade historial de ciclo
            const debtsPayed = movements.filter(move => move.type == 'DEBT' && move.paymentStatus == 'Payed');
            const entrysPayed = movements.filter(move => move.type == 'ENTRY' && move.paymentStatus == 'Payed');
            const debtsPending = movements.filter(move => move.type == 'DEBT' && move.paymentStatus == 'Pending');
            const entrysPending = movements.filter(move => move.type == 'ENTRY' && move.paymentStatus == 'Pending');

            var totalDebtsPayed = 0;
            debtsPayed.forEach(element => { totalDebtsPayed += element.value; });

            var totalentrysPayed = 0;
            entrysPayed.forEach(element => { totalentrysPayed += element.value; });

            var totaldebtsPending = 0;
            debtsPending.forEach(element => { totaldebtsPending += element.value; });

            var totalentrysPending = 0;
            entrysPending.forEach(element => { totalentrysPending += element.value; });

            const histories = budget['histories']
            functions.logger.info(histories);
            const history = {
              'id': (histories?.length ?? 0) + 1,
              'date': Timestamp.fromDate(new Date()),
              'totalPayedDebt': totalDebtsPayed,
              'totalPayedEntry': totalentrysPayed,
              'totalPendingDebt': totaldebtsPending,
              'totalPendingEntry': totalentrysPending,
            };
            snapshot.ref.update({ histories: FieldValue.arrayUnion(history) });

            // Actualizacion de Finalizacion de ciclo en movimientos.
            movements.forEach( movement => { movement.paymentStatus = 'Pending' })
            snapshot.ref.update({ movements: movements });
          });
        }
        return sendMessage('Ciclo finalizado', 'y comenzado uno nuevo, No olvides agregar tus nuevos gastos.', toChat, "resetCycle", "");;
    });

exports.resetBiMonthCycles = functions.pubsub
    .schedule('0 0 1,15 * *')
    .onRun(async (context) => {
        const users = await firestore.collection('users').get()
        const toChat = "endcycle";

        for (const userSnapShot of users.docs) {
          const users = firestore.collection('users')
          const budgets = await users.doc(userSnapShot.id).collection('budgets').where('isCycle', '==', true).where( 'cycle', '==', 0).get()
          if (budgets.empty) { return; }

          budgets.forEach(snapshot => {
            const budget = snapshot.data()
            const movements = budget['movements']

            // Se añade historial de ciclo
            const debtsPayed = movements.filter(move => move.type == 'DEBT' && move.paymentStatus == 'Payed');
            const entrysPayed = movements.filter(move => move.type == 'ENTRY' && move.paymentStatus == 'Payed');
            const debtsPending = movements.filter(move => move.type == 'DEBT' && move.paymentStatus == 'Pending');
            const entrysPending = movements.filter(move => move.type == 'ENTRY' && move.paymentStatus == 'Pending');

            var totalDebtsPayed = 0;
            debtsPayed.forEach(element => { totalDebtsPayed += element.value; });

            var totalentrysPayed = 0;
            entrysPayed.forEach(element => { totalentrysPayed += element.value; });

            var totaldebtsPending = 0;
            debtsPending.forEach(element => { totaldebtsPending += element.value; });

            var totalentrysPending = 0;
            entrysPending.forEach(element => { totalentrysPending += element.value; });

            const histories = budget['histories']
            functions.logger.info(histories);
            const history = {
              'id': (histories?.length ?? 0) + 1,
              'date': Timestamp.fromDate(new Date()),
              'totalPayedDebt': totalDebtsPayed,
              'totalPayedEntry': totalentrysPayed,
              'totalPendingDebt': totaldebtsPending,
              'totalPendingEntry': totalentrysPending,
            };
            snapshot.ref.update({ histories: FieldValue.arrayUnion(history) });

            // Actualizacion de Finalizacion de ciclo en movimientos.
            movements.forEach( movement => { movement.paymentStatus = 'Pending' })
            snapshot.ref.update({ movements: movements });
          });
        }
        return sendMessage('Ciclo finalizado', 'y comenzado uno nuevo, No olvides agregar tus nuevos gastos.', toChat, "resetCycle", "");;
    });

  exports.validateMovementEveryDays = functions.pubsub
      .schedule('every 12 hours')
      .onRun(async (context) => {
        const users = await firestore.collection('users').get()

        for (const userSnapShot of users.docs) {
          const usersCol = firestore.collection('users')
          const budgets = await usersCol.doc(userSnapShot.id).collection('budgets').where('status', '==', 'Active').get()
          if (budgets.empty) { return; }


          var isPendingMovementToMark = false;
          budgets.forEach(snapshot => {
            const budget = snapshot.data()
            const movements = budget['movements']
            const users = budget['users']

            // Actualizacion de Finalizacion de ciclo en movimientos.
            const today = new Date();
            movements.forEach( movement => { 
               
              if (movement.paymentStatus == 'Payed') { return; }

              const days = movement['alert']['days'];
              const dates = movement['alert']['dates'];
              const intensive = movement['alert']['type'] == 'INTENSIVE';

              days.forEach( day => { 
                if (day == today.getDate()) {
                  isPendingMovementToMark = true;
                }
              })

              dates.forEach( date => {
                if (date.day == today.getDay() && date.month == today.getMonth()) {
                  isPendingMovementToMark = true;
                }
              })
            })
            if (isPendingMovementToMark) {
              users.forEach( user => {
                 const topic = "movement" + user.id;
                 sendMessage('Recordatorio!', 'No olvides pagar tus movimientos pendientes y marcarlos como pagados.' , topic, "ALERT_MOVEMENT", budget.id);
              })
              const ownerTopic = "movement" + budget.userID;
              return sendMessage('Recordatorio!', 'No olvides pagar tus movimientos pendientes y marcarlos como pagados.' , ownerTopic, "ALERT_MOVEMENT", budget.id);
            }
          });
        }
    });

exports.modifyMovement = functions.firestore
  .document("/users/{userID}/budgets/{budgetID}")
  .onUpdate((snap, context) => {
    const newBudget = snap.after.data();
    const users = newBudget['users']

    const editedUserID = snap.after.ref.path.split("/")[1];
    const isOwnerBudget = editedUserID == newBudget.userID
    const isEditeBudget = newBudget['editBudget']

    if (!isEditeBudget) { return null; }

    if (!isOwnerBudget) {
      //Envio de mensaje a usuario dueño
      const title = "Presupuesto actualizado";
      const topic = "movement" + newBudget.userID;
      const message = newBudget.ownerName + " han modificado tu presupuesto, revisa que hay de nuevo en el..";
      return sendMessage(title, message, topic, "EDITED", newBudget.id);
    }

    const userEdited = users.find(e => { return e.id == editedUserID; });

     //Envio de mensaje a usuarios invitados
     users.forEach(user => {
       if (isOwnerBudget || userEdited.id != user.id) {
        const title = "Presupuesto actualizado";
        const topic = "movement" + user.id;
        const message = "Han modificado el presupuesto " + newBudget.name + " del que haces parte, revisa que hay de nuevo en el..";
        sendMessage(title, message, topic, "EDITED", newBudget.id);
       }
    });
  });

exports.createBudget = functions.firestore
  .document("/users/{userID}/budgets/{budgetID}")
  .onCreate((snap, context) => {
    const budget = snap.data();
    const users = budget['users']

     //Envio de mensaje a usuarios invitados
     users.forEach(user => {
      const title = "Nuevo presupuesto";
      const topic = "movement" + user.id;
      const message = "Te han invitado al presupuesto " + budget.name + ".";
      sendMessage(title, message, topic, "INVITE", budget.id);
    });
  });

exports.helpCenterMessage = functions.firestore
  .document("/users/{userID}/helpCenter/{conversationID}/messages/{messageID}")
  .onCreate((snap, context) => {
    const message = snap.data();
    const userID = snap.ref.path.split("/")[1];
    const isSender = message['isUserSender'];

    if (!isSender) {
      const title = "Nuevo mensaje de HelpCenter";
      const topic = "helpcenter" + userID;
      const text = message['message'];
      sendMessage(title, text, topic, "HELPCENTER", '');
    }
  });

exports.premiumUpdates = functions.pubsub
  .schedule('0 6 * * *')
  .onRun(async (context) => {
    const users = await firestore.collection('users').get()
    users.forEach( snapshot => {
      const userData = snapshot.data();
      const currentPlan = userData['currentPlan'];
      const today = new Date();
      const endDateString = currentPlan['endDate'].split("T")[0];
      const endDate = Date.parse(endDateString);
      const planID = currentPlan['id'];
      const unlimited = currentPlan['unlimited'];

      if (today > endDate && planID != 'free' && !unlimited) {
        const title = "Malas noticias!";
        const topic = "premium" + userData['id'];
        const name = currentPlan['name'];
        const text = "Se ha vencido tu " + name + ", no dejes atras estos grandisosos beneficios y renueva tu Suscripción.";

        // Se convierte a plan Free
        currentPlan.id = "free"
        currentPlan.name = "Plan Free"

        snapshot.ref.update({ currentPlan: currentPlan });
        sendMessage(title, text, topic, "PREMIUM", '');
      }
    })
  });

exports.recordingMarkDebts = functions.pubsub
  .schedule('0 19 * * *')
  .onRun(async (context) => {
    const topic = 'news'
    const title = "Recordatorio 💸"
    const text = "¡No olvides marcar tus gastos de hoy!"
    sendMessage(title, text, topic, "NEWS", '');
  });


exports.recordingAdd = functions.pubsub
  .schedule('0 20 * * *')
  .onRun(async (context) => {
    const topic = 'news'
    const title = "Recordatorio 💸"
    const text = "¿Ya agregastes tus gastos de hoy?"
    sendMessage(title, text, topic, "NEWS", '');
  });

/**
 * Adds two numbers together.
 * @param {varchar} title of message.
 * @param {varchar} body of message.
 * @param {varchar} topic to send.
 * @param {varchar} action to send.
 * @param {varchar} actionId to send.
 * @return {bool} The sum of the two numbers.
 */
 function sendMessage(title, body, topic, action, actionId) {
    const payload = {
      android: {
        priority: "high",
        data: {
          click_action: "FLUTTER_NOTIFICATION_CLICK",
          priority: "high",
        },
        notification: {
          title: title,
          body: body,
          priority: "high",
          sound: "default",
        },
      },
      data: {
        action: action,
        actionId: actionId,
      },
      apns: {
        payload: {
          aps: {
            alert: {
              title: title,
              subtitle: '',
              body: body,
            },
            sound: "default",
            // contentAvailable: true,
            // mutableContent: true,
            badge: 1,
          },
        },
      },
      topic: topic,
    };
    return admin.messaging().send(payload)
      .then((response) => {
        console.log("true", topic, " - ", action, " - ", response);
        return { success: true };
      })
      .catch((error) => {
        console.log("false", topic, " - ", action, " - ", error);
        return { success: false };
      });
  }
