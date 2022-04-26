##########################################################
## Working with words ####################################
## Created by: Alex Dang #################################
##########################################################


## Load libraries ########################################
library(tidyverse)
library(here)
library(tidytext)
library(wordcloud2)
library(janeaustenr)


## Data Analysis #########################################
  ## {stringr} part of tidyverse
words<- "This is ia string"
words

words_vector <- c("Apples", "Bananas", "Oranges")
words_vector

paste("High temp", "Low pH", sep = "-")   ## add dash between words
paste0("High temp", "Low pH")   ## remove space between words

shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

str_length(shapes)   ## how many letters are in each word

seq_data <- c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4)   ## extract the 2nd to 4th AA
str_sub(seq_data, start = 3, end = 3) <- "A"    ## add an A in the 3rd position
seq_data
str_dup(seq_data, times = c(2,3))    ## times is the number of times to duplicate each string 

badtreatments <- c("High", "High", "High ", "Low", "Low")
badtreatments
str_trim(badtreatments)   ## removes white space
str_trim(badtreatments, side = "left")    ## removes one side or the other; left
str_pad(badtreatments, 5, side = "right")    ## add white space to the right side
str_pad(badtreatments, 5, side = "right", pad = "1")   ## add 1 to the right side after the 5th character

x <- "I love R!"
str_to_upper(x)   ## makes everything upper case
str_to_lower(x)   ## makes everything lower case
str_to_title(x)   ## makes it title case first letter of each word

data <- c("AAA", "TATA", "CTAG", "GCTT")
str_view(data, pattern = "A")    ## find all the strings with an A
str_detect(data, pattern = "A")   ## detect a specific pattern
str_detect(data, pattern = "AT")
str_locate(data, pattern = "AT")   ## locate a pattern

  ## regex
vals <- c("a.b", "b.c", "c.d")
str_replace(vals, "\\.", " ")    ## replacing the periods with space: string, pattern replace
vals1 <- c("a.b.c", "c.d.e")
str_replace(vals1, "\\.", " ")    ## str_replace only replaces the first instance
str_replace_all(vals1, "\\.", " ")    ## replace all the periods
vals2 <- c("test 123", "test 456", "test")
str_subset(vals2, "\\d")    ## subset the vectors to only keep string with digits
str_count(vals2, "[aeiou]")    ## count the number of lowercase vowels in each string
str_count(vals2, "[0-9]")      ## count nay digit

strings <- c("550-153-7578", "banana", 
             "435.114.7586", "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_detect(strings, phone)
test <- str_subset(strings, phone)
test
test %>% 
  str_replace_all(pattern = "\\.", replacement = "-") %>%     ## replace periods with -
  str_replace_all(pattern = "[a-zA-Z]\\:", replacement = "") %>%     ## remove all the things we don't want
  str_trim()    ## trim the white space

head(austen_books())
tail(austen_books())
original_books <- austen_books() %>%     ## get all of Jane Austen's books
  group_by(book) %>% 
  mutate(line = row_number(),     ## find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",      ## count the chapters; start with the word chapter followed by a digit or roman numbers
                                                 ignore_case = TRUE)))) %>%      ## ignore lower or upper case
  ungroup()    ## ungroup it so there's a dataframe again
head(original_books)
tidy_books <- original_books %>% 
  unnest_tokens(output = word, input = text)     ## add a column named word, with the input as the text column
head(tidy_books)

head(get_stopwords())
cleaned_books <- tidy_books %>% 
  anti_join(get_stopwords()) %>%     ## dataframe without the stopwords
  count(word, sort = TRUE)     ## count the most common words across all her books
head(cleaned_books)

sent_word_counts <- tidy_books %>% 
  inner_join(get_sentiments()) %>%     ## only keeps pos or neg words
  count(word, sentiment, sort = TRUE) %>%     ## count them
  filter(n > 150) %>%     ## take only if there are over 150 instances of it 
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%     ## add a column where if the word is negative make the count negative 
  mutate(word = reorder(word, n))     ## sort it so it grows from larger to smallest

ggplot(sent_word_counts, aes(word, n, fill = sentiment)) +
  geom_col() + 
  coord_flip() +
  labs(y = "Contribution to sentiment")

words1 <- cleaned_books %>% 
  count(word) %>%           ## count all the words
  arrange(desc(n)) %>%      ## sort the words
  slice(1:100)              ## take the top 100
wordcloud2(words1, shape = 'triangle', size = 0.3)    ## make a wordcloud out of the top 100 words
