import consumer from "./consumer";

consumer.subscriptions.create(
  { channel: "CommentsChannel", question_id: gon.question_id },
  {
    // connected() {
    //   // Called when the subscription is ready for use on the server
    // },

    received(data) {
      console.log(data);
      var type = data.comment.commentable_type.toLowerCase();
      var id = data.comment.commentable_id;
      console.log(type);

      if (type == "question") {
        $(`.question-comment[data-comment-question=${id}]`).append(
          data["partial"]
        );
      } else {
        $(`.answer-comment[data-comment-answer=${id}`).append(data["partial"]);
      }
      $(".new-comment #comment_body").val("");
      // Called when there's incoming data on the websocket for this channel
    },
  }
);
