require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_page
	puts "Récupération de la page https://coinmarketcap.com/all/views/all/"
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
	# puts page.class   # => Nokogiri::HTML::Document
	return page
end

def get_names(page)
	puts "Récupération des noms des currencies"
	crypto_names = page.xpath('//td[@class="text-left col-symbol"]')

	crypto_names_array = []

	crypto_names.each do |a|
		crypto_names_array << a.text
	end
	return crypto_names_array
end

def get_prices(page)
	puts "Récupération des prix des currencies"
	crypto_prices = page.xpath('//a[@class="price"]')

	crypto_prices_array = []

	crypto_prices.each do |a|
		crypto_prices_array << a.text
	end
	return crypto_prices_array
end

def hash_data(data1,data2)
	puts data1.class
	puts data2.class
	result = []
	data1.each_with_index do |key,value|
		result << { key => data2[value]}
	end

	return result
end

def perform
	page = get_page
	crypto_names_array = get_names(page)
	crypto_prices_array = get_prices(page)

	result = hash_data(crypto_names_array,crypto_prices_array)

	puts result
end

perform 