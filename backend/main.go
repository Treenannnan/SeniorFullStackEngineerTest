package main

import (
	"database/sql"
	"fmt"
	"log"
	"net"
	"os"

	_ "github.com/go-sql-driver/mysql"

	"github.com/backend/internal/storage"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"

	authv1 "github.com/backend/gen/auth/v1"

	authsvc "github.com/backend/internal/auth"

	shopv1 "github.com/backend/gen/shop/v1"

	shopsvc "github.com/backend/internal/shop"

	"github.com/backend/internal/shopmock"
)

func main() {

	dsn := os.Getenv("MYSQL_DSN")
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Println("please check mySql")
		panic(err)
	}
	if err := db.Ping(); err != nil {
		fmt.Println("please check mySql")
		panic(err)
	}

	bind := os.Getenv("BLOB_BIND_ADDR")
	pub := os.Getenv("BLOB_PUBLIC_BASE_URL")

	secret := []byte(os.Getenv("AUTH_JWT_SECRET"))
	addr := os.Getenv("GRPC_ADDR")

	store := storage.NewSQLStore(db)
	blobPath := os.Getenv("BLOB_STORAGE_PATH")
	if blobPath == "" {
		blobPath = ".data/blob"
	}
	blobs, err := shopmock.NewLocalHTTPBlobStore(blobPath, bind, pub)
	if err != nil {
		log.Fatal(err)
	}

	lis, _ := net.Listen("tcp", addr)
	var publicMethods = map[string]bool{
		"/auth.v1.AuthenticationService/SignUp":               true,
		"/auth.v1.AuthenticationService/SignIn":               true,
		"/auth.v1.AuthenticationService/GoogleSignIn":         true,
		"/auth.v1.AuthenticationService/RefreshToken":         true,
		"/auth.v1.AuthenticationService/RequestPasswordReset": true,
		"/auth.v1.AuthenticationService/ResetPassword":        true,
	}

	grpcServer := grpc.NewServer(grpc.UnaryInterceptor(authsvc.AuthUnaryInterceptor(secret, publicMethods)))

	authService := authsvc.NewService(store, secret)
	authv1.RegisterAuthenticationServiceServer(grpcServer, authService)

	shopService := shopsvc.NewService(store, blobs, secret)
	shopv1.RegisterShopServiceServer(grpcServer, shopService)

	reflection.Register(grpcServer)

	log.Println("backend :50051")
	log.Fatal(grpcServer.Serve(lis))
}

/*
	awsPipeline := aihelper.NewPipeline(
		"./.data/blob/audiobooks/1756625477273105900/gameoflife02_scovelshinn_64kb.mp3",
		30,
		"audiobooks-shops",
		"",
		"ap-southeast-1",
		"",
		true,
		false,
		"audiobooks",
	)

	out, err := awsPipeline.ContinueTranscript("https://audiobooks-shops.s3.ap-southeast-1.amazonaws.com/audiobooks/1756715038139717184/gameoflife03_scovelshinn_64kb_clip.mp3", func(state aihelper.PipelineState, o *aihelper.Output) {
		fmt.Println("state:", state)
	})

	/*
			out, err := awsPipeline.Run(func(state aihelper.PipelineState) {
				fmt.Println("state:", state)
			})

				out, err := awsPipeline.ContinueSummary("Chapter one of the game of life and how to play it. This is a Librivox recording. All Librivox recordings are in the public domain. For more information or to volunteer, please visit Librivox.org. The Game of life and how to play it by Florence Scovel Shin. Chapter one. The game. Most people consider life a battle, but it is not a battle. It is a game. It is a game, however, which cannot be played successfully without the knowledge of spiritual law. And the old and the New Testaments give the rules of the game with wonderful clearness. Jesus Christ taught that it was a great game of giving and receiving. Whatsoever a man soeth that shall he also reap. This means that whatever man sends out in word or deed will return to him. What he gives, he will receive. If he gives hate, he will receive hate. If he gives love, he will receive love. If he gives criticism, he will receive criticism. If he lies, he will be lied to. If he cheats, he will be cheated. We are taught also that the imaging faculty plays a leading part in the game of life. Keep thy heart or imagination with all diligence, for out of it are the issues of life. Proverbs 4:23. This means that what man images sooner or later externalizes in his affairs. I know of a man who feared a certain disease. It was a very rare disease and difficult to get, but he pictured it continually and read about it until it manifested in his body, and he died, the victim of distorted imagination. So we see to play successfully the game of life, we must train the imaging faculty. A person with an imaging faculty trained to image only good brings into his life every righteous desire of his heart. Health wealth, love, friends, perfect self-expression, his highest ideals. The imagination has been called the scissors of the mind, and it is ever cutting, cutting day by day the pictures man sees there, and sooner or later he meets his own creations in his outer world to train the imagination successfully, man must understand the workings of his mind. The Greeks said, Know thyself. There are 3 departments of the mind the subconscious, conscious, and superconscious. The subconscious is simply power without direction. It is like steam or electricity, and it does what it is directed to. It has no power of induction. Whatever man feels deeply or images clearly is impressed upon the subconscious mind and carried out in minutesst detail. For example, a woman I know, when a child always made believe she was a widow. She dressed up in black clothes and wore a long black veil, and people thought she was very clever and amusing. She grew up and married a man with whom she was deeply in love. In a short time he died, and she wore black and a sweeping veil for many years. The picture of herself as a widow was so impressed upon the subconscious mind and in due time worked itself out regardless of the havoc created. The conscious mind has been called mortal or carnal mind. It is the human mind and sees life as it appears to be. It sees death, disaster, sickness, poverty, and the limitation of every kind, and it impresses the subconscious. The superconscious mind is the god mind within each man and is the realm of perfect ideas. In it is the perfect pattern spoken of by Plato, the divine design, for there is a divine design for each person. There is a place that you are to fill and no one else can fill something you are to do which no one else can do. There is a perfect picture of this in the superconscious mind. It usually flashes across the conscious as an unattainable ideal, something too good to be true. In reality, it is man's true destiny or destination flashed to him from the infinite intelligence which is within himself. Many people, however, are in ignorance of their true destinies and are striving for things and situations which do not belong to them and would only bring failure and dissatisfaction if attained. For example, a woman came to me and asked me to speak the word that she would marry a certain man with whom she was very much in love. She called him AB. I replied that this would be a violation of spiritual law, but that I would speak the word for the right man, the divine selection, the man who belonged to her by divine right. I added if a B is the right man, you can't lose him, and if he isn't, you will receive his equivalent. She saw AB frequently, but no headway was made in their friendship. One evening she called and said, Do you know, for the last week AB hasn't seemed so wonderful to me. I replied, maybe he is not the divine selection. Another man may be the right one. Soon after that she met another man who fell in love with her at once and who said she was his ideal. In fact, he said all the things that she had always wished AB would say to her. She remarked, it was quite uncanny. She soon returned to his love and lost all interest in AB. This shows the law of substitution. A right idea was substituted for a wrong one. Therefore, there was no loss or sacrifice involved. Jesus Christ said, Seek ye first the kingdom of God and His righteousness, and all these things shall be added unto you. And he said the kingdom was within man. The kingdom is the realm of right ideas or the divine pattern. Jesus Christ taught that man's words played a leading part in the game of life. By your words ye are justified, and by your words ye are condemned. Many people have brought disaster into their lives through idle words. For example, a woman once asked me why her life was now one of poverty of limitation. Formerly she had a home, was surrounded by beautiful things, and had plenty of money. We found she had often tired of the management of her home and had said repeatedly, I'm sick and tired of things. I wish I lived in a trunk. And she added, today I am living in that trunk. She had spoken herself into a trunk. The subconscious mind has no sense of humor, and people often joke themselves into unhappy experiences. For example, a woman who had a great deal of money joked continually about getting ready for the poor house. In a few years she was almost destitute, having impressed the subconscious mind with a picture of lack and limitation. Fortunately, the law works both ways, and a situation of lack may be changed to one of plenty. For example, a woman came to me one hot summer's day for a treatment for prosperity. She was worn out, dejected, and discouraged. She said she possessed just $8 in the world. I said, Good, we'll bless the $8 and multiply them as Jesus Christ multiplied the loaves and the fishes. For he taught that every man had the power to bless and to multiply, to heal and to prosper. She said, What shall I do next? I replied, Follow intuition. Have you a hunch to do anything or to go anywhere? Intuition means intuition or to be taught from within. It is man's unerring guide, and I will deal more fully with its laws in a following chapter. The woman replied, I don't know. I seem to have a hunch to go home. I've just just enough money for car fare. Her home was in a distant city and was one of lack and limitation, and the reasoning mind or intellect would have said stay in New York and get work and make some money. I replied, then go home, never violate a hunch. I spoke the following words for her. Infinite spirit open the way for great abundance for hm, she is an irresistible magnet for all that belongs to her by divine right. I told her to repeat it continually also. She left for home immediately and calling on a woman one day, she linked up with an old friend of her family. Through this friend she received thousands of dollars in a most miraculous way. She has said to me often, Tell people about the woman who came to you with $8 and a hunch. There is always plenty on man's pathway, but it can only be brought into manifestation through desire, faith, or the spoken word. Jesus Christ brought out clearly that man must make the first move. Ask, and it shall be given to you. Seek and ye shall find. Knock, and it shall be opened unto you. Matthew 7:7. In the scriptures we read concerning the works of my hands, command ye me. Infinite intelligence, God is ever ready to carry out man's smallest or greatest demands. Every desire uttered or unexpressed is a demand. We are often startled by having a wish suddenly fulfilled. For example, one Easter, having seen many beautiful rose trees in the florist's windows, I wished I would receive one. And for an instant saw it mentally being carried in the door. Easter came and with it a beautiful rose tree. I thanked my friend the following day and told her it was just what I had wanted. She replied, I didn't send you a rose tree. I sent you lilies. The man had mixed the order and sent me a rose tree simply because I had started the law in action, and I had to have a rose tree. Nothing stands between man and his highest ideals and every desire of his heart but doubt and fear. When man can wish without worrying, every desire will be instantly fulfilled. I will explain more fully in the following chapter the scientific reason for this and how fear must be erased from the consciousness. It is man's only enemy, fear of lack, fear of failure, fear of sickness, fear of loss, and a feeling of insecurity on some plane. Jesus Christ said, Why are ye fearful, O ye of little faith. Matthew 8:26. So we can see we must substitute faith for fear, for fear is only inverted faith. It is faith in evil instead of good. The object of the game of life is to see clearly one's good and to obliterate all mental pictures of evil. This must be done by impressing the subconscious mind with a realization of good. A very brilliant man who has attained great success told me he had suddenly erased all fear from his consciousness by reading a sign which hung in a room. He saw printed in large letters this statement. Why worry it will probably never happen. These words were stamped indelibly upon his subconscious mind, and he now has a firm conviction that only good could come into his life and therefore only good can manifest. In the following chapter, I will deal with the different methods of impressing the subconscious mind. It is man's faithful servant, but one must be careful to give it the right orders. Man has ever a silent listener at his side, his subconscious mind. Every thought, every word is impressed upon it and carried out in amazing detail. It is like a singer making a record on the sensitive disk of the phonographic plate. Every note and tone of the singer's voice is registered. If he coughs or hesitates, it is registered also. So let us break all the old bad records in the subconscious mind, the records of our lives which we do not wish to keep and make new and beautiful ones. Speak these words aloud with power and conviction. I now smash and demolish by my spoken word every untrue record in my subconscious mind. They shall return to the dust heap of their native nothingness, for they came from my own vain imaginings. I now make my perfect records through the Christ within, the records of health, wealth, love, and perfect self-expression. This is the square of life, the game completed. In the following chapters, I will show how man can change his conditions by changing his words. Any man who does not know the power of the word is behind the times. Death and life are in the power of the tongue. Proverbs 18:21 End of chapter one. Recording by Amy Conger.", func(s aihelper.PipelineState) {
					fmt.Println("state:", s)
				})

		if err != nil {
			fmt.Println(err)
		}

	jsonData, err := json.Marshal(out.CategoriesOut)
	if err != nil {
		fmt.Println("Error marshalling JSON:", err)
		return
	}

	fmt.Println(string(jsonData))

	fmt.Println(out.Summary)

	return
*/
