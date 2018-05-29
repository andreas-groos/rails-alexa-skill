class User < ApplicationRecord
  has_secure_password
  has_many :recipes

  validates :email, uniqueness: { case_sensitive: false }, presence: true, email: true
  validates :name, presence: true
  before_create :apply_codeword
  before_validation :downcase_email

  CODEWORDS = ["san francisco", "virginia beach", "fort worth", "los angeles", "chicago", "houston", "philadelphia", "phoenix", "san diego", "dallas", "san antonio", "detroit", "san jose", "jacksonville", "columbus", "austin", "baltimore", "memphis", "milwaukee", "boston", "washington", "el paso", "seattle", "denver", "charlotte", "portland", "oklahoma city", "tucson", "new orleans", "las vegas", "cleveland", "long beach", "albuquerque", "fresno", "atlanta", "sacramento", "oakland", "mesa", "tulsa", "omaha", "minneapolis", "honolulu", "miami", "colorado springs", "wichita", "santa ana", "pittsburgh", "arlington", "cincinnati", "anaheim", "toledo", "tampa", "buffalo", "st. paul", "corpus christi", "aurora", "raleigh", "newark", "anchorage municipalit", "louisville", "riverside", "st. petersburg", "bakersfield", "stockton", "birmingham", "jersey city", "norfolk", "hialeah", "lincoln", "greensboro", "plano", "rochester", "glendale", "akron", "garland", "madison", "fort wayne", "callery boroug", "fremont", "montgomery", "shreveport", "lubbock", "chesapeake", "mobile", "des moines", "grand rapids", "richmond", "yonkers", "spokane", "glendale", "tacoma", "irving", "huntington beach", "arlington", "modesto", "durham", "paradise", "orlando", "boise city", "columbus", "winston-salem", "san bernardino", "jackson", "salt lake city", "reno", "newport news", "chandler", "laredo", "henderson", "knoxville", "amarillo", "providence", "worcester", "oxnard", "dayton", "garden grove", "oceanside", "tempe", "huntsville", "ontario", "sunrise manor", "chattanooga", "springfield", "springfield", "santa clarita", "salinas", "tallahassee", "rockford", "pomona", "paterson", "overland park", "santa rosa", "kansas city", "hampton", "metairie", "lakewood", "vancouver", "irvine", "aurora", "moreno valley", "pasadena", "hayward", "bridgeport", "hollywood", "warren", "torrance", "eugene", "pembroke pines", "salem", "pasadena", "escondido", "sunnyvale", "fontana", "orange", "alexandria", "rancho cucamonga", "fullerton", "corona", "flint", "mesquite", "sterling heights", "yuma", "east los angeles", "sioux falls", "new haven", "topeka", "concord", "evansville", "hartford", "cedar rapids", "elizabeth", "lansing", "lancaster", "fort collins", "coral springs", "spring valley", "stamford", "vallejo", "palmdale", "columbia", "el monte", "abilene", "north las vegas", "ann arbor", "beaumont", "waco", "independence", "peoria", "springfield", "simi valley", "lafayette", "gilbert", "carrollton", "bellevue", "west valley city", "clearwater", "costa mesa", "peoria", "downey", "waterbury", "manchester",  "san francisco" ,  "virginia beach" ,  "fort worth" ,  "los angeles" ,  "chicago" ,  "houston" ,  "philadelphia" ,  "phoenix" ,  "san diego" ,  "dallas" ,  "san antonio" ,  "detroit" ,  "san jose" ,  "jacksonville" ,  "columbus" ,  "austin" ,  "baltimore" ,  "memphis" ,  "milwaukee" ,  "boston" ,  "washington" ,  "el paso" ,  "seattle" ,  "denver" ,  "charlotte" ,  "portland" ,  "oklahoma city" ,  "tucson" ,  "new orleans" ,  "las vegas" ,  "cleveland" ,  "long beach" ,  "albuquerque" ,  "fresno" ,  "atlanta" ,  "sacramento" ,  "oakland" ,  "mesa" ,  "tulsa" ,  "omaha" ,  "minneapolis" ,  "honolulu" ,  "miami" ,  "colorado springs" ,  "wichita" ,  "santa ana" ,  "pittsburgh" ,  "arlington" ,  "cincinnati" ,  "anaheim" ,  "toledo" ,  "tampa" ,  "buffalo" ,  "st. paul" ,  "corpus christi" ,  "aurora" ,  "raleigh" ,  "newark" ,  "anchorage municipalit" ,  "louisville" ,  "riverside" ,  "st. petersburg" ,  "bakersfield" ,  "stockton" ,  "birmingham" ,  "jersey city" ,  "norfolk" ,  "hialeah" ,  "lincoln" ,  "greensboro" ,  "plano" ,  "rochester" ,  "glendale" ,  "akron" ,  "garland" ,  "madison" ,  "fort wayne" ,  "callery boroug" ,  "fremont" ,  "montgomery" ,  "shreveport" ,  "lubbock" ,  "chesapeake" ,  "mobile" ,  "des moines" ,  "grand rapids" ,  "richmond" ,  "yonkers" ,  "spokane" ,  "glendale" ,  "tacoma" ,  "irving" ,  "huntington beach" ,  "arlington" ,  "modesto" ,  "durham" ,  "paradise" ,  "orlando" ,  "boise city" ,  "columbus" ,  "winston-salem" ,  "san bernardino" ,  "jackson" ,  "salt lake city" ,  "reno" ,  "newport news" ,  "chandler" ,  "laredo" ,  "henderson" ,  "knoxville" ,  "amarillo" ,  "providence" ,  "worcester" ,  "oxnard" ,  "dayton" ,  "garden grove" ,  "oceanside" ,  "tempe" ,  "huntsville" ,  "ontario" ,  "sunrise manor" ,  "chattanooga" ,  "springfield" ,  "springfield" ,  "santa clarita" ,  "salinas" ,  "tallahassee" ,  "rockford" ,  "pomona" ,  "paterson" ,  "overland park" ,  "santa rosa" ,  "kansas city" ,  "hampton" ,  "metairie" ,  "lakewood" ,  "vancouver" ,  "irvine" ,  "aurora" ,  "moreno valley" ,  "pasadena" ,  "hayward" ,  "bridgeport" ,  "hollywood" ,  "warren" ,  "torrance" ,  "eugene" ,  "pembroke pines" ,  "salem" ,  "pasadena" ,  "escondido" ,  "sunnyvale" ,  "fontana" ,  "orange" ,  "alexandria" ,  "rancho cucamonga" ,  "fullerton" ,  "corona" ,  "flint" ,  "mesquite" ,  "sterling heights" ,  "yuma" ,  "east los angeles" ,  "sioux falls" ,  "new haven" ,  "topeka" ,  "concord" ,  "evansville" ,  "hartford" ,  "cedar rapids" ,  "elizabeth" ,  "lansing" ,  "lancaster" ,  "fort collins" ,  "coral springs" ,  "spring valley" ,  "stamford" ,  "vallejo" ,  "palmdale" ,  "columbia" ,  "el monte" ,  "abilene" ,  "north las vegas" ,  "ann arbor" ,  "beaumont" ,  "waco" ,  "independence" ,  "peoria" ,  "springfield" ,  "simi valley" ,  "lafayette" ,  "gilbert" ,  "carrollton" ,  "bellevue" ,  "west valley city" ,  "clearwater" ,  "costa mesa" ,  "peoria" ,  "downey" ,  "waterbury" ,  "manchester"]

  #
  # Let's just save these as downcase to prevent any confusion.
  #
  def downcase_email
    self.email = self.email.strip.downcase
  end

  #
  # Each user will need to "link" their alexa user id to their user id in repeat my
  #   recipes.  At the time of writing, the system is just going to allocate a
  #   numeric 4 digit pin that belongs to that user until they authenticate.
  #
  # Why?  Because Amazon has a pretrained 4 digit number slot.  And there is no way
  #   that more than 1 person will ever be signing up at a time.
  #
  def apply_codeword


    outstanding_codewords = User.select(:codeword)
                                .where(:amazon_user_identifier => nil)
                                .map {|i| i.codeword}


    available_codewords = CODEWORDS - outstanding_codewords
    raise "you are a victim of success" if available_codewords.blank?
    self.codeword = available_codewords.sample
  end


end
