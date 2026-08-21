////
////  DummyArticleData.swift
////  NewsCom
////
////  Created by ANJALI SHARMA R on 24/05/26.
////
//
//
//
//class DummyArticleData {
//    
//    static let shared = DummyArticleData()
//    
//    let articles: [Article]  = [
//        
//        Article(
//                title: "Apple Intelligence Changes the Future of iPhone",
//                    
//                headline: "Apple introduces a deeply integrated AI system across iPhone, iPad and Mac, bringing real-time writing tools, image generation and smarter Siri experiences.",
//                    
//                content:  """
//        Apple officially unveiled its next-generation artificial intelligence platform called Apple Intelligence during its annual developer conference, marking one of the company’s biggest software announcements in years.
//
//        The new AI system is designed to work seamlessly across iPhone, iPad and Mac devices while prioritizing user privacy through on-device processing and Private Cloud Compute technology.
//
//        Craig Federighi, Apple’s Senior Vice President of Software Engineering, described the feature as “personal intelligence built for everyday life.”
//
//        Among the most anticipated additions is a significantly upgraded Siri experience. Siri can now understand context across applications, summarize emails, rewrite notes and even perform multi-step tasks between apps without requiring manual switching.
//
//        Apple also introduced Image Playground, a lightweight image generation tool integrated directly into Messages and Notes. Users can create stylized visuals and custom emojis using simple prompts.
//
//        Industry analysts believe Apple’s cautious but deeply integrated approach to AI could differentiate it from competitors racing to release standalone chatbot products.
//
//        The company emphasized that many AI requests will remain entirely on-device, reducing privacy concerns that have increasingly surrounded large language models in recent years.
//
//        Developers will gain access to Apple Intelligence APIs later this year, with the first public rollout expected alongside the next iPhone launch.
//        """,
//                    
//                    imageURL: "news1",
//                    
//                    author: "Ethan Walker",
//                    
//                    authorImage: "author1",
//                    
//                    topic: "Technology",
//                    
//                    readTime: "6 min read",
//                    
//                    publishedTime: "2 hours ago"
//                ),
//        
//        Article(
//                    title: "Global Markets Rally After Strong Tech Earnings",
//                    
//                    headline: "Stock markets surged worldwide as major technology companies reported stronger-than-expected quarterly earnings.",
//                    
//                    content:
//        """
//        Global financial markets experienced a broad rally on Tuesday following impressive earnings reports from several major technology companies.
//
//        The Nasdaq climbed nearly 2 percent during morning trading, while European and Asian markets also posted gains amid renewed investor confidence.
//
//        Analysts attributed the momentum largely to stronger advertising revenue, rapid cloud computing growth and continued expansion in artificial intelligence investments.
//
//        Investors were particularly optimistic about semiconductor manufacturers after multiple firms projected increased demand for AI-focused hardware through 2027.
//
//        Despite concerns around inflation and interest rates, traders appeared encouraged by signs that consumer spending remains resilient.
//
//        “The technology sector is once again carrying global market sentiment,” said Rebecca Lin, senior market strategist at Morgan Capital.
//
//        Meanwhile, oil prices remained relatively stable, and bond yields saw only modest movement as investors shifted toward higher-risk assets.
//
//        Financial experts cautioned that volatility may still return later in the quarter as central banks continue evaluating inflation data.
//        """,
//                    
//                    imageURL: "news2",
//                    
//                    author: "Sophia Bennett",
//                    
//                    authorImage: "author2",
//                    
//                    topic: "Finance",
//                    
//                    readTime: "5 min read",
//                    
//                    publishedTime: "45 minutes ago"
//                ),
//        
//        Article(
//                    title: "Scientists Discover Potentially Habitable Planet",
//                    
//                    headline: "Astronomers have identified a nearby exoplanet that may contain conditions suitable for liquid water and life.",
//                    
//                    content:
//        """
//        An international team of astronomers announced the discovery of a potentially habitable exoplanet located approximately 40 light-years away from Earth.
//
//        The planet, currently designated Kepler-442c II, orbits within the habitable zone of a red dwarf star, where temperatures may allow liquid water to exist on the surface.
//
//        Researchers used advanced spectroscopy and infrared imaging to analyze atmospheric conditions surrounding the planet.
//
//        Early findings suggest the presence of water vapor and carbon-rich compounds, although scientists emphasized that additional observations are required before drawing conclusions about possible life.
//
//        “This is one of the most promising Earth-like discoveries we’ve made in the last decade,” said Dr. Elena Morris of the European Southern Observatory.
//
//        The discovery has reignited discussions around future deep-space telescope missions focused specifically on biosignature detection.
//
//        NASA and ESA are expected to collaborate on follow-up studies using next-generation orbital observatories launching later this decade.
//        """,
//                    
//                    imageURL: "news3",
//                    
//                    author: "Daniel Carter",
//                    
//                    authorImage: "author3",
//                    
//                    topic: "Science",
//                    
//                    readTime: "7 min read",
//                    
//                    publishedTime: "1 hour ago"
//                ),
//        
//        Article(
//                    title: "Taylor Swift Dominates Grammy Awards Again",
//                    
//                    headline: "Taylor Swift secured multiple Grammy wins in a record-breaking night for the global pop superstar.",
//                    
//                    content:
//        """
//        Taylor Swift once again dominated the Grammy Awards, taking home Album of the Year alongside several additional honors during a historic evening in Los Angeles.
//
//        The singer received standing ovations throughout the ceremony as fans celebrated another milestone in her already legendary career.
//
//        Critics praised Swift’s latest album for its emotional songwriting, experimental production and commercial success across streaming platforms.
//
//        Social media exploded moments after the awards announcement, with hashtags related to Swift trending globally within minutes.
//
//        Music analysts noted that the artist continues redefining industry expectations by maintaining both massive sales and critical acclaim simultaneously.
//
//        “This level of consistency is almost unprecedented in modern pop music,” said entertainment journalist Carla Hughes.
//
//        The ceremony also featured surprise performances from several artists, though Swift’s appearance remained the highlight of the night for most viewers.
//        """,
//                    
//                    imageURL: "news4",
//                    
//                    author: "Mia Thompson",
//                    
//                    authorImage: "author4",
//                    
//                    topic: "Entertainment",
//                    
//                    readTime: "4 min read",
//                    
//                    publishedTime: "30 minutes ago"
//                ),
//        
//        Article(
//                    title: "AI Startups Continue Massive Hiring Wave",
//                    
//                    headline: "Artificial intelligence companies are rapidly expanding teams as global investment in AI reaches record levels.",
//                    
//                    content:
//        """
//        Artificial intelligence startups across Silicon Valley and Europe are continuing an aggressive hiring wave amid unprecedented investor interest in the sector.
//
//        Several companies announced plans to double engineering and research teams before the end of the year as competition intensifies.
//
//        Recruiters say demand for machine learning engineers, product designers and AI safety researchers has increased dramatically since early 2025.
//
//        Industry leaders believe the rapid expansion reflects growing enterprise adoption of generative AI systems across healthcare, education, finance and media.
//
//        However, experts also warned that the pace of hiring may create challenges around regulation, ethics and long-term sustainability.
//
//        “Every company wants AI talent right now,” explained startup advisor Kevin Walsh. “The competition is becoming extremely intense.”
//
//        Funding for AI startups globally surpassed $110 billion this year, according to recent venture capital estimates.
//        """,
//                    
//                    imageURL: "news5",
//                    
//                    author: "Olivia Reed",
//                    
//                    authorImage: "author5",
//                    
//                    topic: "Technology",
//                    
//                    readTime: "5 min read",
//                    
//                    publishedTime: "15 minutes ago"
//                ),
//        
//        Article(
//            title: "Heavy Rainfall Brings Bengaluru Traffic to a Standstill",
//            
//            headline: "Several parts of Bengaluru witnessed severe flooding and traffic congestion after overnight rainfall disrupted normal life across the city.",
//            
//            content:
//        """
//        Heavy rainfall across Bengaluru caused massive traffic congestion and waterlogging on Wednesday morning, leaving commuters stranded for hours in several major areas.
//
//        Roads near Silk Board Junction, Outer Ring Road and Koramangala experienced severe flooding as drainage systems overflowed after continuous overnight rain.
//
//        Visuals shared on social media showed vehicles partially submerged while pedestrians struggled to navigate flooded streets during peak office hours.
//
//        The India Meteorological Department issued a yellow alert for the city and warned residents to expect additional rainfall over the next 48 hours.
//
//        Many technology companies operating in Bengaluru advised employees to work remotely due to unsafe commuting conditions.
//
//        Civic authorities stated that emergency teams had been deployed to clear blocked drains and restore traffic movement in affected regions.
//
//        Residents once again raised concerns about urban infrastructure and recurring monsoon flooding despite repeated promises of long-term solutions by city officials.
//
//        Local businesses reported delayed deliveries and reduced customer activity as the rain continued throughout the afternoon.
//        """,
//            
//            imageURL: "news6",
//            
//            author: "Rahul Menon",
//            
//            authorImage: "author6",
//            
//            topic: "India",
//            
//            readTime: "5 min read",
//            
//            publishedTime: "20 minutes ago"
//        ),
//        
//        Article(
//            title: "Netflix’s New Sci-Fi Thriller Becomes Global Sensation",
//            
//            headline: "A newly released sci-fi series on Netflix has broken streaming records within days of its worldwide release.",
//            
//            content:
//        """
//        Netflix’s latest science-fiction thriller has rapidly become one of the platform’s biggest global hits, topping streaming charts across more than 70 countries.
//
//        The series, titled Eclipse Protocol, combines futuristic storytelling with political intrigue and psychological suspense, drawing comparisons to classic sci-fi franchises.
//
//        Critics praised the show’s visual effects, cinematic production quality and emotionally driven performances from its lead cast.
//
//        Fans flooded online forums with theories and discussions shortly after the first season premiered, helping the series trend worldwide on social media platforms.
//
//        Industry analysts believe the success highlights growing demand for high-budget streaming originals capable of competing with theatrical releases.
//
//        Netflix executives described the launch as “one of the strongest audience debuts in recent company history.”
//
//        The platform has reportedly already approved development for a second season following overwhelming viewership numbers during opening weekend.
//        """,
//            
//            imageURL: "news7",
//            
//            author: "Claire Dawson",
//            
//            authorImage: "author7",
//            
//            topic: "Entertainment",
//            
//            readTime: "4 min read",
//            
//            publishedTime: "1 hour ago"
//        ),
//        
//        Article(
//            title: "Indian Cricket Team Clinches Dramatic Series Victory",
//            
//            headline: "India secured a thrilling final-over victory against Australia in one of the most intense matches of the year.",
//            
//            content:
//        """
//        India defeated Australia in dramatic fashion during the deciding match of the bilateral cricket series, sealing victory with only two balls remaining.
//
//        The packed stadium erupted in celebration as India chased down a difficult target following a tense final over filled with momentum swings.
//
//        Star batter Virat Kohli delivered a match-winning innings under immense pressure, while younger players provided crucial support during the closing stages.
//
//        Australia’s bowling attack initially dominated the middle overs, reducing India to a challenging position before an aggressive late partnership shifted the game.
//
//        Cricket analysts described the contest as one of the most entertaining limited-overs matches in recent years.
//
//        Fans across the country celebrated the victory online, with clips of the final moments rapidly going viral across social media platforms.
//
//        The Indian captain praised the team’s composure and resilience during the post-match presentation ceremony.
//        """,
//            
//            imageURL: "news8",
//            
//            author: "Arjun Kapoor",
//            
//            authorImage: "author8",
//            
//            topic: "Sports",
//            
//            readTime: "6 min read",
//            
//            publishedTime: "10 minutes ago"
//        ),
//        
//        Article(
//            title: "Luxury Travel Trends Shift Toward Slow Tourism",
//            
//            headline: "Travel experts say tourists are increasingly choosing slower, experience-focused vacations over packed itineraries.",
//            
//            content:
//        """
//        The global travel industry is witnessing a major shift toward “slow tourism,” with travelers prioritizing meaningful experiences over fast-paced sightseeing schedules.
//
//        Luxury resorts and travel agencies reported increased demand for extended stays, wellness retreats and eco-friendly destinations during the past year.
//
//        Industry experts say travelers are seeking deeper cultural immersion and less stressful travel experiences after years of post-pandemic lifestyle changes.
//
//        Countries including Japan, Italy and New Zealand have introduced new travel programs focused on sustainable tourism and local community engagement.
//
//        Travel influencers on social media have also contributed to the trend by promoting long-form travel experiences instead of crowded tourist attractions.
//
//        Airlines and hospitality brands are adapting their strategies to appeal to younger travelers who value flexibility, wellness and authenticity.
//
//        Analysts predict the slow tourism market will continue expanding significantly over the next decade.
//        """,
//            
//            imageURL: "news9",
//            
//            author: "Emily Ross",
//            
//            authorImage: "author9",
//            
//            topic: "Travel",
//            
//            readTime: "5 min read",
//            
//            publishedTime: "3 hours ago"
//        ),
//        
//        Article(
//            title: "Researchers Develop Battery That Charges in Five Minutes",
//            
//            headline: "Scientists claim a breakthrough battery technology could dramatically reduce electric vehicle charging times.",
//            
//            content:
//        """
//        A team of researchers has announced the development of a next-generation battery capable of charging electric vehicles in under five minutes.
//
//        The breakthrough technology uses advanced graphene-based materials designed to improve energy transfer speed while maintaining battery stability and lifespan.
//
//        Scientists involved in the project believe the innovation could solve one of the biggest challenges facing widespread electric vehicle adoption.
//
//        Initial testing demonstrated promising performance under high-temperature and rapid-charging conditions without significant degradation.
//
//        Automotive manufacturers are already exploring potential partnerships to commercialize the technology within the next few years.
//
//        Experts say faster charging infrastructure may significantly accelerate the global transition away from traditional fuel-powered transportation.
//
//        Environmental groups welcomed the announcement, describing it as an important step toward reducing long-term carbon emissions.
//        """,
//            
//            imageURL: "news10",
//            
//            author: "Noah Bennett",
//            
//            authorImage: "author10",
//            
//            topic: "Science",
//            
//            readTime: "7 min read",
//            
//            publishedTime: "50 minutes ago"
//        ),
//        
//        Article(
//            title: "Apple Introduces AI Features Across iPhone Lineup",
//            headline: "Apple revealed a new set of AI-powered tools designed to improve productivity and personalization.",
//            content:  """
//        Apple announced a major expansion of artificial intelligence features during its annual developer conference, introducing smarter Siri interactions, writing tools and real-time app suggestions.
//        The company stated that the new system focuses heavily on privacy by processing most requests directly on-device rather than relying entirely on cloud servers.
//
//        Executives demonstrated AI-assisted email summaries, photo organization and automatic notification prioritization during the keynote presentation.
//
//        Industry analysts believe the announcement marks Apple’s strongest entry yet into the rapidly growing AI software race dominated by competing technology companies.
//
//        Developers will gain access to new APIs allowing third-party apps to integrate Apple Intelligence into their own workflows later this year. 
//                Apple announced a major expansion of artificial intelligence features during its annual developer conference, introducing smarter Siri interactions, writing tools and real-time app suggestions.
//
//                The company stated that the new system focuses heavily on privacy by processing most requests directly on-device rather than relying entirely on cloud servers.
//
//                Executives demonstrated AI-assisted email summaries, photo organization and automatic notification prioritization during the keynote presentation.
//
//                Industry analysts believe the announcement marks Apple’s strongest entry yet into the rapidly growing AI software race dominated by competing technology companies.
//
//                Developers will gain access to new APIs allowing third-party apps to integrate Apple Intelligence into their own workflows later this year.
//        """,
//                imageURL: "news1",
//                author: "Daniel Lee",
//                authorImage: "author1",
//                topic: "Technology",
//                readTime: "5 min read",
//                publishedTime: "15 minutes ago"
//            ),
//
//            Article(
//                title: "Google Expands Gemini AI Integration",
//                headline: "Google is embedding Gemini AI deeper into Search, Android and Workspace products.",
//                content:
//        """
//        Google announced broader integration of Gemini AI across its ecosystem as competition intensifies in the artificial intelligence sector.
//
//        The company showcased advanced AI-generated summaries directly within search results and introduced productivity tools capable of drafting emails and presentations.
//
//        Executives highlighted multimodal capabilities allowing Gemini to process text, images and voice inputs simultaneously.
//
//        Technology experts believe the move could significantly change how users interact with search engines and mobile devices over the next decade.
//                Google announced broader integration of Gemini AI across its ecosystem as competition intensifies in the artificial intelligence sector.
//
//                The company showcased advanced AI-generated summaries directly within search results and introduced productivity tools capable of drafting emails and presentations.
//
//                Executives highlighted multimodal capabilities allowing Gemini to process text, images and voice inputs simultaneously.
//
//                Technology experts believe the move could significantly change how users interact with search engines and mobile devices over the next decade.
//        """,
//                imageURL: "news2",
//                author: "Sophia Turner",
//                authorImage: "author2",
//                topic: "Technology",
//                readTime: "4 min read",
//                publishedTime: "1 hour ago"
//            ),
//
//            Article(
//                title: "Samsung Reveals Foldable Tablet Prototype",
//                headline: "Samsung showcased a futuristic foldable tablet concept during a technology expo in Seoul.",
//                content:
//        """
//        Samsung unveiled a next-generation foldable tablet featuring a flexible OLED display designed for multitasking and immersive media experiences.
//
//        The prototype demonstrated seamless transitions between tablet and compact portable modes while maintaining high display quality.
//
//        Company representatives stated the technology could become commercially available within the next few years depending on manufacturing scalability. Samsung unveiled a next-generation foldable tablet featuring a flexible OLED display designed for multitasking and immersive media experiences.
//        
//        The prototype demonstrated seamless transitions between tablet and compact portable modes while maintaining high display quality.
//
//        Company representatives stated the technology could become commercially available within the next few years depending on manufacturing scalability. Samsung unveiled a next-generation foldable tablet featuring a flexible OLED display designed for multitasking and immersive media experiences.
//        
//        The prototype demonstrated seamless transitions between tablet and compact portable modes while maintaining high display quality.
//
//        Company representatives stated the technology could become commercially available within the next few years depending on manufacturing scalability. Samsung unveiled a next-generation foldable tablet featuring a flexible OLED display designed for multitasking and immersive media experiences.
//        
//        The prototype demonstrated seamless transitions between tablet and compact portable modes while maintaining high display quality.
//
//        Company representatives stated the technology could become commercially available within the next few years depending on manufacturing scalability.
//        """,
//                imageURL: "news3",
//                author: "Marcus Hill",
//                authorImage: "author3",
//                topic: "Technology",
//                readTime: "3 min read",
//                publishedTime: "2 hours ago"
//            ),
//
//            Article(
//                title: "Cybersecurity Firms Warn of Rising AI Scams",
//                headline: "Experts say AI-generated scams are becoming increasingly difficult to detect.",
//                content:
//        """
//        Cybersecurity companies warned consumers about a sharp increase in sophisticated scams powered by generative AI tools.
//
//        Experts reported cases involving cloned voices, realistic phishing emails and fake video calls designed to trick victims into sharing sensitive information.
//
//        Authorities encouraged users to verify suspicious communications and avoid sharing personal details without confirmation. Cybersecurity companies warned consumers about a sharp increase in sophisticated scams powered by generative AI tools.
//        
//        Experts reported cases involving cloned voices, realistic phishing emails and fake video calls designed to trick victims into sharing sensitive information.
//
//        Authorities encouraged users to verify suspicious communications and avoid sharing personal details without confirmation. Cybersecurity companies warned consumers about a sharp increase in sophisticated scams powered by generative AI tools.
//        
//        Experts reported cases involving cloned voices, realistic phishing emails and fake video calls designed to trick victims into sharing sensitive information.
//
//        Authorities encouraged users to verify suspicious communications and avoid sharing personal details without confirmation. Cybersecurity companies warned consumers about a sharp increase in sophisticated scams powered by generative AI tools.
//        
//        Experts reported cases involving cloned voices, realistic phishing emails and fake video calls designed to trick victims into sharing sensitive information.
//
//        Authorities encouraged users to verify suspicious communications and avoid sharing personal details without confirmation.
//        """,
//                imageURL: "news4",
//                author: "Olivia Grant",
//                authorImage: "author4",
//                topic: "Technology",
//                readTime: "6 min read",
//                publishedTime: "45 minutes ago"
//            ),
//
//            Article(
//                title: "Startups Race to Build Humanoid Robots",
//                headline: "Robotics companies are investing heavily in humanoid assistants for homes and workplaces.",
//                content:
//        """
//        Several technology startups introduced humanoid robot prototypes capable of performing repetitive household and industrial tasks.
//
//        Investors believe advancements in AI and motion control systems are accelerating the development of commercially viable robotics platforms.
//
//        Experts say humanoid robots could become common in warehouses, healthcare facilities and customer service roles within the next decade.
//        """,
//                imageURL: "news5",
//                author: "Nathan Brooks",
//                authorImage: "author5",
//                topic: "Technology",
//                readTime: "5 min read",
//                publishedTime: "30 minutes ago"
//            ),
//
//
//
//            Article(
//                title: "India Wins Thrilling Cricket Final Against Australia",
//                headline: "India secured a dramatic last-over victory in front of a packed stadium crowd.",
//                content:
//        """
//        India defeated Australia in a dramatic final-over finish during the championship match held in Mumbai.
//
//        Fans erupted in celebration after a stunning boundary sealed victory with only two balls remaining.
//
//        Analysts described the game as one of the most entertaining cricket matches in recent years due to its intense momentum swings. India defeated Australia in a dramatic final-over finish during the championship match held in Mumbai.
//        
//        Fans erupted in celebration after a stunning boundary sealed victory with only two balls remaining.
//
//        Analysts described the game as one of the most entertaining cricket matches in recent years due to its intense momentum swings. India defeated Australia in a dramatic final-over finish during the championship match held in Mumbai.
//        
//        Fans erupted in celebration after a stunning boundary sealed victory with only two balls remaining.
//
//        Analysts described the game as one of the most entertaining cricket matches in recent years due to its intense momentum swings. India defeated Australia in a dramatic final-over finish during the championship match held in Mumbai.
//        
//        Fans erupted in celebration after a stunning boundary sealed victory with only two balls remaining.
//
//        Analysts described the game as one of the most entertaining cricket matches in recent years due to its intense momentum swings.
//        """,
//                imageURL: "news6",
//                author: "Arjun Kapoor",
//                authorImage: "author6",
//                topic: "Sports",
//                readTime: "6 min read",
//                publishedTime: "10 minutes ago"
//            ),
//
//            Article(
//                title: "Chelsea Clinch Late Victory in Premier League Clash",
//                headline: "Chelsea scored in stoppage time to secure a crucial league win.",
//                content:
//        """
//        Chelsea secured a dramatic 2-1 victory after a stoppage-time goal stunned their opponents during a tense Premier League encounter.
//
//        The match remained evenly balanced throughout the second half before the decisive moment sparked celebrations among home supporters.
//
//        Managers praised both teams for delivering an intense and highly competitive performance. Chelsea secured a dramatic 2-1 victory after a stoppage-time goal stunned their opponents during a tense Premier League encounter.
//        
//        The match remained evenly balanced throughout the second half before the decisive moment sparked celebrations among home supporters.
//
//        Managers praised both teams for delivering an intense and highly competitive performance. Chelsea secured a dramatic 2-1 victory after a stoppage-time goal stunned their opponents during a tense Premier League encounter.
//        
//        The match remained evenly balanced throughout the second half before the decisive moment sparked celebrations among home supporters.
//
//        Managers praised both teams for delivering an intense and highly competitive performance. Chelsea secured a dramatic 2-1 victory after a stoppage-time goal stunned their opponents during a tense Premier League encounter.
//        
//        The match remained evenly balanced throughout the second half before the decisive moment sparked celebrations among home supporters.
//
//        Managers praised both teams for delivering an intense and highly competitive performance.
//        """,
//                imageURL: "news7",
//                author: "Liam Carter",
//                authorImage: "author7",
//                topic: "Sports",
//                readTime: "4 min read",
//                publishedTime: "25 minutes ago"
//            ),
//
//            Article(
//                title: "Olympic Committee Announces New Mixed Events",
//                headline: "Several new mixed-gender events will debut at the next Olympic Games.",
//                content:
//        """
//        Olympic organizers confirmed the addition of multiple mixed-team events aimed at increasing inclusivity and audience engagement.
//
//        The committee stated the changes reflect evolving global interest in balanced competition formats across various sports.
//
//        Athletes welcomed the decision, calling it an exciting step forward for international competition. Olympic organizers confirmed the addition of multiple mixed-team events aimed at increasing inclusivity and audience engagement.
//        
//        The committee stated the changes reflect evolving global interest in balanced competition formats across various sports.
//
//        Athletes welcomed the decision, calling it an exciting step forward for international competition. Olympic organizers confirmed the addition of multiple mixed-team events aimed at increasing inclusivity and audience engagement.
//        
//        The committee stated the changes reflect evolving global interest in balanced competition formats across various sports.
//
//        Athletes welcomed the decision, calling it an exciting step forward for international competition. Olympic organizers confirmed the addition of multiple mixed-team events aimed at increasing inclusivity and audience engagement.
//        
//        The committee stated the changes reflect evolving global interest in balanced competition formats across various sports.
//
//        Athletes welcomed the decision, calling it an exciting step forward for international competition.
//        """,
//                imageURL: "news8",
//                author: "Emma Hughes",
//                authorImage: "author8",
//                topic: "Sports",
//                readTime: "5 min read",
//                publishedTime: "2 hours ago"
//            ),
//
//            Article(
//                title: "Formula One Introduces New Sustainability Rules",
//                headline: "F1 teams will adopt stricter sustainability regulations beginning next season.",
//                content:
//        """
//        Formula One officials announced a major sustainability initiative targeting reduced carbon emissions and greener race operations.
//
//        The new rules include cleaner fuel requirements, energy-efficient logistics and updated manufacturing standards for participating teams.
//
//        Executives described the move as essential for the long-term future of motorsport. Formula One officials announced a major sustainability initiative targeting reduced carbon emissions and greener race operations.
//        
//        The new rules include cleaner fuel requirements, energy-efficient logistics and updated manufacturing standards for participating teams.
//
//        Executives described the move as essential for the long-term future of motorsport.  Formula One officials announced a major sustainability initiative targeting reduced carbon emissions and greener race operations.
//        
//        The new rules include cleaner fuel requirements, energy-efficient logistics and updated manufacturing standards for participating teams.
//
//        Executives described the move as essential for the long-term future of motorsport. Formula One officials announced a major sustainability initiative targeting reduced carbon emissions and greener race operations.
//        
//        The new rules include cleaner fuel requirements, energy-efficient logistics and updated manufacturing standards for participating teams.
//
//        Executives described the move as essential for the long-term future of motorsport.
//        """,
//                imageURL: "news9",
//                author: "Chris Walker",
//                authorImage: "author9",
//                topic: "Sports",
//                readTime: "5 min read",
//                publishedTime: "50 minutes ago"
//            ),
//
//            Article(
//                title: "Tennis Star Makes Stunning Comeback After Injury",
//                headline: "A former world champion returned to competition with an impressive straight-set victory.",
//                content:
//        """
//        Fans celebrated the return of a former tennis champion following months of recovery from a serious injury.
//
//        The athlete displayed remarkable composure and athleticism during the comeback match, winning comfortably in straight sets.
//
//        Commentators described the performance as one of the most inspiring moments of the tournament so far. Fans celebrated the return of a former tennis champion following months of recovery from a serious injury.
//        
//        The athlete displayed remarkable composure and athleticism during the comeback match, winning comfortably in straight sets.
//
//        Commentators described the performance as one of the most inspiring moments of the tournament so far. Fans celebrated the return of a former tennis champion following months of recovery from a serious injury.
//        
//        The athlete displayed remarkable composure and athleticism during the comeback match, winning comfortably in straight sets.
//
//        Commentators described the performance as one of the most inspiring moments of the tournament so far. Fans celebrated the return of a former tennis champion following months of recovery from a serious injury.
//        
//        The athlete displayed remarkable composure and athleticism during the comeback match, winning comfortably in straight sets.
//
//        Commentators described the performance as one of the most inspiring moments of the tournament so far.
//        """,
//                imageURL: "news10",
//                author: "Mia Collins",
//                authorImage: "author10",
//                topic: "Sports",
//                readTime: "4 min read",
//                publishedTime: "1 hour ago"
//            ),
//
//
//            Article(
//                title: "Netflix Thriller Breaks Streaming Records",
//                headline: "A new sci-fi series has become the platform’s most watched release this month.",
//                content:
//        """
//        Netflix reported record-breaking global viewership numbers for its latest science-fiction thriller series.
//
//        Fans praised the show’s cinematic visuals, suspenseful storytelling and emotionally driven performances.
//
//        Industry experts say streaming platforms are increasingly investing in blockbuster-style original productions to attract global audiences. Netflix reported record-breaking global viewership numbers for its latest science-fiction thriller series.
//        
//        Fans praised the show’s cinematic visuals, suspenseful storytelling and emotionally driven performances.
//
//        Industry experts say streaming platforms are increasingly investing in blockbuster-style original productions to attract global audiences. Netflix reported record-breaking global viewership numbers for its latest science-fiction thriller series.
//        
//        Fans praised the show’s cinematic visuals, suspenseful storytelling and emotionally driven performances.
//
//        Industry experts say streaming platforms are increasingly investing in blockbuster-style original productions to attract global audiences. Netflix reported record-breaking global viewership numbers for its latest science-fiction thriller series.
//        
//        Fans praised the show’s cinematic visuals, suspenseful storytelling and emotionally driven performances.
//
//        Industry experts say streaming platforms are increasingly investing in blockbuster-style original productions to attract global audiences.
//        """,
//                imageURL: "news11",
//                author: "Claire Dawson",
//                authorImage: "author11",
//                topic: "Entertainment",
//                readTime: "5 min read",
//                publishedTime: "40 minutes ago"
//            ),
//
//            Article(
//                title: "Taylor Swift Announces Surprise World Tour Dates",
//                headline: "Fans rushed online after the singer revealed additional concert locations.",
//                content:
//        """
//        Taylor Swift surprised fans by announcing new dates for her ongoing world tour during a live social media broadcast.
//
//        Ticketing websites experienced heavy traffic moments after the announcement as millions attempted to secure seats.
//
//        Music analysts predict the expanded tour could generate record-breaking revenue worldwide. Taylor Swift surprised fans by announcing new dates for her ongoing world tour during a live social media broadcast.
//        
//        Ticketing websites experienced heavy traffic moments after the announcement as millions attempted to secure seats.
//
//        Music analysts predict the expanded tour could generate record-breaking revenue worldwide. Taylor Swift surprised fans by announcing new dates for her ongoing world tour during a live social media broadcast.
//        
//        Ticketing websites experienced heavy traffic moments after the announcement as millions attempted to secure seats.
//
//        Music analysts predict the expanded tour could generate record-breaking revenue worldwide. Taylor Swift surprised fans by announcing new dates for her ongoing world tour during a live social media broadcast.
//        
//        Ticketing websites experienced heavy traffic moments after the announcement as millions attempted to secure seats.
//
//        Music analysts predict the expanded tour could generate record-breaking revenue worldwide.
//        """,
//                imageURL: "news12",
//                author: "Isabella Reed",
//                authorImage: "author12",
//                topic: "Entertainment",
//                readTime: "3 min read",
//                publishedTime: "1 hour ago"
//            ),
//
//            Article(
//                title: "Marvel Reveals New Phase of Superhero Films",
//                headline: "Marvel Studios introduced upcoming projects during a fan convention event.",
//                content:
//        """
//        Marvel Studios officially announced several new superhero films and streaming series planned for release over the next few years.
//
//        The studio teased returning characters, unexpected crossovers and darker storylines during a presentation attended by thousands of fans.
//
//        Social media reactions quickly dominated entertainment trends worldwide. Marvel Studios officially announced several new superhero films and streaming series planned for release over the next few years.
//        
//        The studio teased returning characters, unexpected crossovers and darker storylines during a presentation attended by thousands of fans.
//
//        Social media reactions quickly dominated entertainment trends worldwide. Marvel Studios officially announced several new superhero films and streaming series planned for release over the next few years.
//        
//        The studio teased returning characters, unexpected crossovers and darker storylines during a presentation attended by thousands of fans.
//
//        Social media reactions quickly dominated entertainment trends worldwide. Marvel Studios officially announced several new superhero films and streaming series planned for release over the next few years.
//        
//        The studio teased returning characters, unexpected crossovers and darker storylines during a presentation attended by thousands of fans.
//
//        Social media reactions quickly dominated entertainment trends worldwide. 
//        """,
//                imageURL: "news13",
//                author: "Noah Bennett",
//                authorImage: "author13",
//                topic: "Entertainment",
//                readTime: "6 min read",
//                publishedTime: "2 hours ago"
//            ),
//
//            Article(
//                title: "Independent Film Wins International Awards",
//                headline: "A low-budget independent drama received critical acclaim at major festivals.",
//                content:
//        """
//        An independent drama film captured international attention after winning multiple awards during a prestigious film festival.
//
//        Critics praised the project’s storytelling, cinematography and emotional performances despite its limited production budget.
//
//        Industry insiders believe the success highlights growing audience appreciation for smaller original films. An independent drama film captured international attention after winning multiple awards during a prestigious film festival.
//        
//        Critics praised the project’s storytelling, cinematography and emotional performances despite its limited production budget.
//
//        Industry insiders believe the success highlights growing audience appreciation for smaller original films. An independent drama film captured international attention after winning multiple awards during a prestigious film festival.
//        
//        Critics praised the project’s storytelling, cinematography and emotional performances despite its limited production budget.
//
//        Industry insiders believe the success highlights growing audience appreciation for smaller original films. An independent drama film captured international attention after winning multiple awards during a prestigious film festival.
//        
//        Critics praised the project’s storytelling, cinematography and emotional performances despite its limited production budget.
//
//        Industry insiders believe the success highlights growing audience appreciation for smaller original films.
//        """,
//                imageURL: "news14",
//                author: "Rachel Adams",
//                authorImage: "author14",
//                topic: "Entertainment",
//                readTime: "4 min read",
//                publishedTime: "3 hours ago"
//            ),
//
//            Article(
//                title: "Music Streaming Revenue Continues to Grow",
//                headline: "Streaming platforms now account for the majority of global music industry revenue.",
//                content:
//        """
//        A new industry report showed music streaming subscriptions continue driving significant growth across the entertainment sector.
//
//        Analysts observed increased listener engagement and rising global demand for digital audio services.
//
//        Record labels are investing heavily in emerging artists and exclusive streaming partnerships. A new industry report showed music streaming subscriptions continue driving significant growth across the entertainment sector.
//        
//        Analysts observed increased listener engagement and rising global demand for digital audio services.
//
//        Record labels are investing heavily in emerging artists and exclusive streaming partnerships. A new industry report showed music streaming subscriptions continue driving significant growth across the entertainment sector.
//        
//        Analysts observed increased listener engagement and rising global demand for digital audio services.
//
//        Record labels are investing heavily in emerging artists and exclusive streaming partnerships. A new industry report showed music streaming subscriptions continue driving significant growth across the entertainment sector.
//        
//        Analysts observed increased listener engagement and rising global demand for digital audio services.
//
//        Record labels are investing heavily in emerging artists and exclusive streaming partnerships.
//        """,
//                imageURL: "news15",
//                author: "Ella Morgan",
//                authorImage: "author15",
//                topic: "Entertainment",
//                readTime: "5 min read",
//                publishedTime: "20 minutes ago"
//            )
//    ]
//
//}
