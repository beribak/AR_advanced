# 1.
    A relational database is a set of tables linked to each other by a system of primary keys and foreign keys
# 2.
1:N  # one to many
N:N # many to many
1:1 # one to one
# 3.
# 4. 
# 5.
    SQL: Structured Query Language
# 6.
    SELECT * FROM books WHERE publishing_year < 1985
# 7.
    SELECT * FROM books
    JOIN authors ON books.author_id = authors.id
    WHERE authors.name = "Jules Verne"
    ORDER BY books.publishing_year DESC
    LIMIT 3 
# 8.
    Active Record is what we call an Object-Relational Mapping. Its purpose is to map the instance variables of our models in our Ruby program to the columns of the corresponding tables in our SQL database
# 9.
    A migration is a change in our database structure (its schema): tables, columns or relations between tables
# 10.
    rake db:migrate
# 11.
    class CreateAuthors < ActiveRecord::Migration[6.0]
        def change
            create_table :authors do |t|
                t.string :name
                t.timestamps
            end
        end
    end
# 12.
class CreateBooks < ActiveRecord::Migration[6.0]
    def change
        create_table :books do |t|
            t.string :title
            t.integer :publishing_year

            t.references :author, foreign_key: true
            t.timestamps
        end
    end
   end
# 13.
class CreateUsers < ActiveRecord::Migration[6.0]
    def change
        create_table :users do |t|
            t.string :email

            t.timestamps
        end
    end
  end
# 14.
class CreateReadingDates < ActiveRecord::Migration[6.0]
    def change
        create_table :reading_dates do |t|
            t.date :date
            t.references :user, foreign_key: true 
            t.references :book, foreign_key: true

            t.timestamps
        end
    end
end
# 15.
class AddCategoryToBooks < ActiveRecord::Migration[6.0]
    def change
       add_column :books, :category, :string
    end
end
  
# 16.
class Author
    has_many :books
end

class Book
    belongs_to :author
    has_many :reading_dates
    has_many :users, through: :reading_dates
end

class User
    has_many :reading_dates
    has_many :books, through: :reading_dates
end

class ReadingDate
    belongs_to :user
    belongs_to :book
end

# 17.

#1. Add your favorite author to the DB
Author.create(name: "Jules Verne")
#======================================
    author = Author.new(name: "Jules Verne")
    author.save
#2. Get all authors
    Author.all
#3. Get author with id=8
    Author.find(8)
#4. Get author with name="Jules Verne", store it in a variable: jules
    jules = Author.find_by(name: "Jules Verne")
#5. Get Jules Verne's books
    jules.books
#6. Create a new book "20000 Leagues under the Seas". Store it in a variable: twenty_thousand
    twenty_thousand = Book.new(title: "20000 Leagues under the Seas")
    #7. Add Jules Verne as this book's author
    twenty_thousand.author = jules
    #8. Now save this book in the DB! 
    twenty_thousand.save


# 18. 
class Author
    validates :name, presence: true
end

# 19.
NO