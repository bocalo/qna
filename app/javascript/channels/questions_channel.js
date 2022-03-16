import consumer from "./consumer";

consumer.subscriptions.create(
  { channel: "QuestionsChannel" },
  {
    // connected() {
    //   console.log("connected");
    //   this.perform("follow");
    // },
    received(data) {
      console.log(data);
      // $(".questions-list").append(data["partial"]);
    },
  }
);
