require 'mailgun'

class HomeController < ApplicationController
    def index
    end
    def write

        @receiver = params[:receiver]
        @title = params[:title]
        @content = params[:content]
        
        new_post = Post.new
        new_post.receiver = @receiver
        new_post.title = @title
        new_post.content = @content
        new_post.save
        
        redirect_to "/list"
                
        mg_client = Mailgun::Client.new("key-b0eccaff6c377c091ed73325362e9bea")

        message_params =  {
                   from: 'jeongah90@galaxy.yonsei.ac.kr',
                   to:   @receiver,
                   subject: @title,
                   text:    @content
                  }

        result = mg_client.send_message('sandboxb635782caacd45a28596054dd4d17a2b.mailgun.org', message_params).to_h!

        message_id = result['id']
        message = result['message']
        
    end
    
    def list
        @every_post = Post.all.order("id desc")
    end
    
end
