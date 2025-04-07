class BooksController < ApplicationController
    def index
        @books = Book.all  
    end
    def show
        @book = Book.find_by!(id: params[:id])
    rescue ActiveRecord::RecordNotFound => e
        Rails.logger.debug("Record not found")
        redirect_to root_path
        
    end

    def edit
        @book = Book.find_by!(id: params[:id])
    end
    def update
    
        @book = Book.find_by!(id: params[:id])
       if @book.update(book_params) 
        redirect_to book_path(@book)
       else 
        render :edit, status: :unprocessable_entity
    end
end

  private 
      def book_params
        params.expect(book: [:name, :author])
      end

 end
