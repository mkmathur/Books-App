require './goodreads'
require "test/unit"

class TestGoodreads < Test::Unit::TestCase
	def setup
		doc = Document.new File.read("data.xml")
		@shelf = Goodreads::Shelf.new(doc)
		@book = @shelf[0]
	end

	def test_title
		assert_equal("Good Omens: The Nice and Accurate Prophecies of Agnes Nutter, Witch", @book.title)
	end

	def test_authors
		assert_equal("Terry Pratchett", @book.author)
	end

	def test_isbn
		assert_equal("0060853980", @book.isbn)
	end

	def test_isbn13
		assert_equal("9780060853983", @book.isbn13)
	end

	def test_image_url
		assert_equal("http://d.gr-assets.com/books/1392528568s/12067.jpg", @book.img_url)
	end

	def test_link
		assert_equal("http://www.goodreads.com/book/show/12067.Good_Omens", @book.link)
	end

	def test_average_rating
		assert_equal("4.27", @book.avg_rating)
	end

	def test_ratings_count
		assert_equal("192748", @book.ratings_count)
	end

	def test_shelves
		#todo
	end

	def test_date_added
		#todo
	end
end
