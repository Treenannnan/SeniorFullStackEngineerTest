# SeniorFullStackEngineerTest
project for Nexus AI senior fullstack engineer
<br>
<br>
https://nexusai-asia.notion.site/Senior-Full-Stack-Engineer-Case-Study-2491ce757f2f80ff8f7bfe48ffcbbfb8
<br>
<br>
Tech Stack<br>
1. Python: เหมาะกับงานที่ต้องใช้การประมวลผลสูงๆ อย่าง ai โดยเลือกมาใช้ในการจัดการ ai service โดยใช้ ทำ transcript โดยใช้ whisper  และ summary โดยใช้ llama3.1 8b<br>
2. Golang: เหมาะกับงานที่ต้องการ concurrent สูงๆ ลองรับ load สูงๆ อย่าง backend services โดยเลือกมาใช้จัดการ authentication service  และ shop service<br>
3. Flutter: เหมาะกับงาน frontend โดยเฉพาะกับทำงานระหว่าง android และ iOS ที่ต้องการ ui ที่หน้าตาเหมือนกัน ในการทำรอบเดียว เลือกมาใช้เป็น android client<br>
4. MySQL: database ที่เลือกใช้ เหมาะกับการจัดการ transactions อย่าง ระบบ cart, checkout, purchase<br>
5. อื่นๆ ก็มีใช้ gRPC, k6, docker <br>
<br>
<br>
Authentication System<br>
1. มีระบบสมัครสมาชิกโดยใช้ google login และ email password<br>
2. ระบบ email password สามารถ reset password ได้ hash password บน database<br>
3. ใช้ JWT token ในการจัดการ interceptor บน gRPC <br>
<br>
<br>
Admin System<br>
1. admin สามารถสร้าง audiobook ได้ โดยการ ตั้งชื่อ ตั้งราคา และเลือก audio file เพื่อ สร้าง audiobook <br>
2. ขั้นตอนจะเริ่มจาก upload ไปที่ server -> server upload ขึ้น cloud(s3) -> ai transcripts โหลด audio file จาก cloud มา processes -> หลังจากได้ transcripts, ai summary จะนำ transcripts มาจัด categories และ description -> บันถึกลง database<br>
<br>
<br>
User System<br>
3. สามารถเลือกซื้อ audiobooks ได้ โดยสามารถ filter category และ อ่าน description ก่อนตัดสินใจซื้อได้<br>
4. สามารถกด add to cart เพื่อเพิ่มไปยังตะกร้าได้ โดยในตะกร้าสามารถลบ audiobook ได้ หากเปลี่ยนใจ<br>
5. สามารถ checkout audiobooks ที่อยู่ใน cart ได้ โดยจะเป็นการ mockup ซึ่งจะ ซื้อสำเร็จเสมอ<br>
6. หลังจากซื้อ audiobooks จะไปอยู่ในส่วน purchased ซึ่งในหน้านี้ user จะสามารถ download audio file หรือ กดดู transcript ของ audiobook ที่ซื้อมาแล้วได้<br>
<br>
<br>
Screenshotted : อยู่ใน folder Screenshots
<br>
Test Case System : test case จะ implement โดยใช้ go test ซึ่งเป็นระบบของ go<br>
1. Authentication test cases:<br>
    - Sign-up and Sign-in : สร้าง user ใหม่ด้วยอีเมลสุ่ม + รหัสผ่านที่กำหนด -> เรียก sign-In ด้วยอีเมล/รหัสผ่านเดียวกัน<br>
    - Sign-up Exist Email: sign-up ซ้ำด้วยอีเมลเดิม -> sign-up ครั้งที่สองด้วยอีเมลเดิมแต่รหัสต่างกัน<br>
    - Password System: sign-in ด้วยรหัสผ่านผิด -> sign-up ผู้ใช้ใหม่ด้วยรหัสผ่านใหม่ -> Sign-in อีกครั้งด้วยด้วยรหัสผ่านที่ไม่ตรง<br>
    - Refresh token: ทดสอบ refresh token แล้ว token เก่าจะต้องใช้ไม่ได้<br>
    Validate token: ทดสอบ token ดีกับไม่ดี<br>
    - Password reset flow: sign-up ผู้ใช้ใหม่ -> ขอ reset token จาก request password reset -> ลอง reset password ด้วย reset token ที่ไม่ถูก -> ลอง reset password ด้วย reset token ที่ถูกต้อง<br>
    - Revoke Token: SignUp เสร็จแล้วสั่ง revoke token -> ลอง revoke token เดิมอีกครั้ง<br>
<br>
<br>
2. Shop test case:<br>
    - Admin create & upload audiobook -> Admin force resume pipeline steps -> List audiobooks -> User add to cart & checkout -> User get download URL<br>
<br>
<br>
Edge Case Handle: หากในตอนที่กำลัง processes หลังจากเริ่มกดสร้าง audiobook ไม่ว่าจะจาก backend service หรือ ai service เราจะแบ่งขั้นตอนการ process เป็น step คือ upload -> transcript-> summary->done ถ้าหาก พังที่ step ไหน admin สามารถกลับมากด resume ในภายหลังได้ตลอด หรือแม้แต่ทำสำเร็จแล้ว แต่ description หรือ category ไม่ถูกใจ ก็สามารถกลับมาทำใหม่ได้ตลอด และ เราได้ทำระบบ ai provider ไว้ หากมีอันไหนมีปัญหา ก็สามารถสลับด้วยตัวเองแล้วทำงานต่อได้ทันที<br>
<br>
<br>
Graceful handling: หากมี process สร้าง audiobook ล้มเหลว จะขึ้นแจ้ง connection fail โดย admin สามารถกลับมากด resume ได้โดยง่าย โดยไม่จำเป็นต้องรู้ว่า ล้มเหลวที่จุดไหน แต่สามารถกด resume ได้ทันที ระบบจะจัดการต่อให้เอง<br>
<br>
<br>
Requirement:<br>
    Nvidia Cuda, Cudnn<br>
    Docker<br>
    Make, Cmake<br>
    k6<br>
<br>
<br>
Setup Backend ,AI and Database:<br>
    - clone Project<br>
    - set AWS_ACCESS_KEY_ID และ AWS_SECRET_ACCESS_KEY ใน docker-compose.yaml<br>
    - run make deploy <br>
    - run make docker-go-test<br>
    - run k6 run .\k6_auth_load_test.js <br>
<br>
<br>
APK URL : https://drive.google.com/file/d/1TviyhpphlJL0p4HhixVzP_kHiNNLV2Rg/view?usp=sharing

Simple K6 load test (authentication)
![Alt text](Screenshots/k6LoadTest.png)


Live demo url: https://drive.google.com/file/d/1ctL6uNrs2W8iwfg2_BxI8O82BVl4cAfx/view?usp=sharing

Sequence Flow:

![alt text](sequenceflow.png)

Architecture Diagrams:

![alt text](diagram.png)

