from bs4 import BeautifulSoup as bs
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import requests

driver = webdriver.Chrome(ChromeDriverManager().install())

class CollegeDataUrl:
    def __init__(self, url, base_url,driver):
        
        self.base_url= base_url
        self.driver = driver
        self.driver.get(url)

    def scrape(self):

        while True:
            try:
                loadmore = self.driver.find_element_by_id("loadMoreButton")
                loadmore.click()
            except Exception as e:
                print("Reached bottom of page")
                break
        
        soup = bs(self.driver.page_source,'html.parser')
        title = soup.find_all('div', class_="title")
        listC =[]
        for ht in title:
            anchor = ht.find_all('a')
            for a in anchor:
                listC.append(a['href'])
        
        return listC
    
def manipulateSearch(url):
    res = f'{url[0:10]}courses-{url[10:]}'
    dictionary = {
        'new' : res,
        'old' : url
    }
    return dictionary

c = CollegeDataUrl('https://www.collegedekho.com/engineering/colleges-in-maharashtra/','https://www.collegedekho.com/',driver)
collegeURL = c.scrape()


def generator(course):
        name = course.find('h5')[0].text
        print(name)
        dictionary = {
            'name' : name,
            'cutoff' : 'NA'
        }
        return dictionary

def check(v1,v2):
    if v2=='N/A':
        return v1
    else:
        return v2

class GetCollegeInfo:
    def __init__(self,  collegeList, baseUrl, driver):
        self.baseUrl = baseUrl
        self.driver = driver
        
        self.collegeList = collegeList

    

    def scrape(self, url, old):
        self.driver.get(self.baseUrl + url)
        while True:
            try:
                loadmore = self.driver.find_element(By.CLASS_NAME,"view_all")
                loadmore.click()
            except Exception as e:
                print("Reached bottom of page")
                break

        
        try :
            soup = bs(self.driver.page_source,'html.parser')
            info = soup.find('div', class_='collegeInfo')
            logo = info.find('img')
            desc = soup.find('div','collegeDesc')
            college_name = desc.find('h1').text.strip().rstrip().replace('Courses & Fees', '')
            address = desc.find('span', class_='location').text.strip()
            courseData = soup.find_all('div', class_='innerDiv coursesData')
            courses = []
            fees = 0
            for course in courseData:
                cname = course.find('h5').text.strip().rstrip()
                fees = fees if course.find('div', 'intakeBlock').find('span').text.replace('INR','').lstrip().rstrip().strip() == 'N/A' else course.find('div', 'intakeBlock').find('span').text.replace('INR','').lstrip().rstrip().strip()
                courses.append({
                    'course' : cname.strip().rstrip(),
                    'cutoff' : 0
                })

            self.driver.get(self.baseUrl + old)
            self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            soup = bs(self.driver.page_source,'html.parser')
            gallery = soup.find("ul", class_="owl-gallery owl-carousel owl-theme owl-loaded owl-drag")

            image = gallery.find('img', class_='lazy')['data-gsll-src']
            im = soup.find('div', class_="content ReadMoreCommon").find('img')['data-gsll-src']
            if (len(courses)>4):
                courses = courses[0:4]
            return {
                'college' : college_name,
                'courses' : courses,
                'address' : address,
                'collegeFees' : fees,
                'imageUrl' : [logo['src'],im,image]
            }
        except Exception as e:
            print(e) 


        
        


    def get_data(self):
        
        result = list(map(manipulateSearch, self.collegeList))
        # print(result)
        a =[]
        for url in result:
            a.append(self.scrape(url['new'],url['old']))

        return a


g = GetCollegeInfo(collegeURL,' https://www.collegedekho.com', driver)

a = g.get_data()

print(a)

#migrate to mongo
from pymongo import MongoClient
client = MongoClient('')

db = client['College-helper']

collection = db['colleges']

def batch_insert(data, batch_size=2):
    l = len(data)
    batch = 0
    while True:
        if (batch+batch_size>l):
            break
        try:
            collection.insert_many(data[batch:batch+batch_size])
        except Exception as e:
            batch=batch+1
        batch = batch+1
    
    # collection.insert_many(data[batch*batch_size:])


batch_insert(a)