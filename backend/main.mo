import Nat "mo:base/Nat";

import Array "mo:base/Array";
import Time "mo:base/Time";
import Text "mo:base/Text";
import Int "mo:base/Int";

actor {
  // Define the Post type
  type Post = {
    id: Nat;
    title: Text;
    body: Text;
    author: Text;
    timestamp: Int;
  };

  // Stable variable to store posts
  stable var posts : [Post] = [];
  stable var nextId : Nat = 0;

  // Query to get all posts
  public query func getPosts() : async [Post] {
    Array.sort(posts, func(a: Post, b: Post) : { #less; #equal; #greater } {
      Int.compare(b.timestamp, a.timestamp)
    })
  };

  // Update call to create a new post
  public func createPost(title: Text, body: Text, author: Text) : async () {
    let newPost : Post = {
      id = nextId;
      title = title;
      body = body;
      author = author;
      timestamp = Time.now();
    };
    posts := Array.append(posts, [newPost]);
    nextId += 1;
  };
}
