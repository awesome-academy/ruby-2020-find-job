module FindJob
  module V1
    class Posts < Grape::API
      version "v1"
      format :json
 
      resource :posts do
        desc "Return list of all post"
        get do
          Post.all
        end

        desc "Return a post"
        params do
          requires :id, type: Integer, desc: "Post id"
        end
        route_param :id do
          get do
            Post.find_by id: params[:id]
          end
        end

        desc "Update a post"
        params do
          requires :id, type: Integer, desc: "Post id"
          requires :title, type: String, desc: "Title"
          requires :description, type: String, desc: "Description"
          requires :salary, type: Integer, desc: "Salary"
          requires :address, type: String, desc: "Address"
          requires :target_type, type: Integer, desc: "Target_type"
          requires :start_date, type: Date, desc: "Start date"
          requires :end_date, type: Date, desc: "End date"
        end
        patch ":id/" do
          load_post params[:id]
          if @post.present?
            @post.update(
              title: params[:title],
              description: params[:description],
              salary: params[:salary],
              address: params[:address],
              target_type: params[:target_type],
              start_date: params[:start_date],
              end_date: params[:end_date]
            )
          end
        end

        desc "delete a post"
        delete ":id/" do
          load_post params[:id]
          if @post.present?
            @post.destroy
          end
        end
      end

      helpers do 
        def load_post id
          @post = Post.find_by id: id
        end
      end
    end
  end
end
