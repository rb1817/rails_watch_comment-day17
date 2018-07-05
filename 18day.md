### 좋아요 버튼 만들기



### 댓글 만들기

* form(요소)이 제출(이벤트)될 때(이벤트 리스너)
* form에 input(요소)안에 있는 내용물(요소)을 받아서
* ajax 요청으로 서버에 '/create/comment'로 요청을 보낸다.
* 보낼 때에는 내용물, 현재 보고있는 movie의 id 값도 같이 보낸다.
* 서버에서 저장하고, response 보내줄 js.erb 파일을 작성한다.
* js.erb 파일에서는 댓글이 표시될 영역에 등록된 댓글의 내용을 추가해준다.





### comment model 만들기

* column: user_id, movie_id, contents

* association: 

  * movie(1) - comment(n)
  * user(1)-comment(n)

* 다하면 ajax 코드

  url("/movies/:movie_id/comments",method:post)인 ajax 코드 짜보기

  ```html
  <script>
      $(document).on('ready', function(){
          $('.like').on('click', function() {
              console.log('like!!!!')
              $.ajax({
                 url: '/likes/<%= @movie.id %>'
              });
          });
          $('.comment').on('submit',function(e){
              e.preventDefault();
             var comm = $('.comment-contents').val(); 
             console.log(comm);
             $.ajax({
                 url: "/movies/<%=@movie.id%>/comments",
                 method: "POST",
                 data: {
                     contents: comm
                 }
             })
          });
          $(document).on('click','.destroy-comment', function(){
             console.log("destroyed!!"); 
          
             var comment_id = $(this).attr('data-id');
             //$(this).data('id');
             $.ajax({
                 url: "/movies/comments/" + comment_id,
                 method: "delete"
             })
          });
      });
  </script>
  ```

  ```ruby
  resources :movies do
      member do
        post '/comments' => 'movies#create_comment'
      end
      
     collection do
         delete '/comments/:comment_id' => 'movies#destroy_comment'
     end
    end
  ```

  ```ruby
    def create_comment
      @comment = Comment.create(user_id: current_user.id, movie_id: @movie.id,contents: params[:contents])
    end
    
    def destroy_comment
      @comment=Comment.find(params[:comment_id]).destroy
    end
  ```

  



```
    member do
      get '/test' => 'movies#test'
    end
    
    ->test_movie GET    /movies/:id/test(.:format) 
    
    collection do
      get '/test' => 'movies#test'
    end
    
    ->/movies/test(.:format)
```





* 수정 버튼을 클릭하면 
* 댓글이 있던 부분이 입력창으로 바뀌면서 원래 있던 댓글의 내용이 입력창에 들어간다.
* 수정버튼은 확인 버튼으로 바뀐다.

* 내용 수정 후 확인 버튼을 클릭하면
* 입력창에 있던 내용물이 댓글의 원래 형태로 바뀌고
* 확인버튼은 다시 수정버튼으로 바뀐다.
* 입력창에 있던 내용물을 ajax로 서버에 요청을 보낸다.
* 서버에서는 해당 댓글을 찾아 내용을 업데이트 한다.





* 수정 버튼을 누르면 
* 전체 문서 중에서 `update-comment` 클래스를 가진 버튼이 있는 경우에
* 더이상 진행하지 않고 이벤트 핸들러를 끝냄 return false;