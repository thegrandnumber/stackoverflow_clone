module ZenQuote
  extend ActiveSupport::Concern

  def get_quote
    url = "https://api.github.com/zen"
    response = HTTParty.get(url)
    if response.code == 403 || response.code==401
      array = ["Life is about making an impact, not making an income", "Whatever the mind of man can conceive and believe, it can achieve", "Strive not to be a success, but rather to be of value", "Two roads diverged in a wood, and I—I took the one less traveled by, And that has made all the difference.", "You miss 100% of the shots you don’t take."]
      return_string = array.sample
    else
     return_string  = response
    end
    return_string 
  end

end