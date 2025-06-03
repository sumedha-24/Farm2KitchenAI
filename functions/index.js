// Import modules
// #1
const functions = require("firebase-functions"),
  admin = require("firebase-admin");

// always initialize admin
// #2
admin.initializeApp();

// create a const to represent firestore
// #3
const db = admin.firestore();

// Create a new background trigger function
// #4
exports.addTimeStampToUser = functions
  .runWith({
    timeoutSeconds: 240, // Give timeout // #5
    memory: "512MB", // memory allotment // #5
  })
  .firestore.document("users/{userId}")
  .onCreate(async (_, context) => {
    // Get current timestamp from server
    // #6
    let curTimeStamp = admin.firestore.Timestamp.now();
    // Print current timestamp on server
    // # 7
    functions.logger.log(`curTimeStamp ${curTimeStamp.seconds}`);

    try {
      // add the new value to new users document
      // #8
      await db
        .collection("users")
        .doc(context.params.userId)
        .set(
          {
            registeredAt: curTimeStamp,
            favTempleList: [],
            favShopsList: [],
            favEvents: [],
          },
          { merge: true }
        );
      // if its done print in logger
      // #7
      functions.logger.log(
        `The current timestamp added to users collection:  ${curTimeStamp}`
      );
      // always return something to end the function execution
      return { status: 200 };
    } catch (e) {
      // Print error incase of errors
      // #7
      functions.logger.log(
        `Something went wrong could not add timestamp to users collectoin ${curTimeStamp}`
      );
      // return status 400 for error
      return { status: 400 };
    }
  });
