class SystemMailer < ApplicationMailer
    #default from: 'aaaaaaaaaa@bbbbb.ccc'
    def testmail
        @greeting = "Hello"
        mail(
            from: 'harada.itservice@gmail.com',
            to:   'oldtimer.masa@gmail.com',
            subject: '＜テストメール＞BugsCooking'
        ) do |format|
            format.text #テキストメールを指定
            #format.html #HTMLメールを指定
        end
    end

    def reset_password_mail(user)
        @user = user
        mail(
            from: 'harada.itservice@gmail.com',
            to:   'oldtimer.masa@gmail.com',
            subject: '＜BugsCooking＞パスワード再発行'
        ) do |format|
            format.text #テキストメールを指定
            #format.html #HTMLメールを指定
        end
    end

end
