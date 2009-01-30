class CommentsController < ApplicationController
  before_filter :load_post
  
  # GET /comments/new
  # GET /comments/new.xml
#  def new
#    @comment = @post.comments.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @comment }
#    end
#  end

  def new
    @comment = @post.comments.new
  end



  # POST /comments
  # POST /comments.xml
  def create
    unless (params[:email_address]).blank?
      @comment = @post.comments.build(params[:comment])
      respond_to do |format|
        if @comment.save
          #mailers
          unless @comment.email.ends_with?('@micahrich.com')
            CommentMailer.deliver_micah_notifier(@comment)
          end
          @comments = Comment.find(:all, :conditions => ["post_id = ? AND email != ? AND email != ?", @comment.post_id, @comment.email, '*@micahrich.com' ])
            for @reciever in @comments
              CommentMailer.deliver_comment_notifier(@reciever, @comment)
            end
          
          flash[:notice] = "Thanks for the comment, I added it below."
          format.html { redirect_to(@post, @comment) }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
        else
          flash[:notice] = "Aw, I couldn't save it. Please double check all the boxes!"
#          format.html { redirect_to(@post, @comment) }
          format.html { render :action => :new }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    else
       flash[:notice] = "Aw, you filled out the wrong boxes. Unforuntately, your comment looks like spam!"
      #format.html { redirect_to(@post, @comment) }
       format.html { redirect_to(@post) }
    end
  end


  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_path(@post)) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def load_post
      @post = Post.find(params[:post_id])
    end
    

  
end
