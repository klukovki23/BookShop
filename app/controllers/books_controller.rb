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
        redirect_to book_path(@book), notice:"Book updated successfully"
       else 
        render :edit, status: :unprocessable_entity
    end
end

    def new
     @book = Book.new
    end

    def create 
        @book = Book.new(book_params)
        if @book.save
          redirect_to book_path(@book), notice: "Book created successfully"
       
        else 
          render :new, status: :unprocessable_entity
        end
    end

    def destroy 
        book = Book.find_by!(id: params[:id])
        book.destroy
        redirect_to books_path, notice: "Book deleted successfully!"
    end

  private 
      def book_params
        params.expect(book: [:name, :author])
      end

 end
