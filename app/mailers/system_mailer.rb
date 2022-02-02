class SystemMailer < ApplicationMailer
    #default from: 'aaaaaaaaaa@bbbbb.ccc'
    def testmail
        @greeting = "Hello"
        mail(
            from: ENV['MYAPP_MAIL_AUTH_USER'],
            to:   ENV['MYAPP_MAIL_AUTH_USER'],
            subject: '＜テストメール＞BugsCooking'
        ) do |format|
            format.text #テキストメールを指定
            #format.html #HTMLメールを指定
        end
    end

    # アカウントの本登録案内
    def account_activation_mail(user)
        @user = user
        mail(
            from: ENV['MYAPP_MAIL_AUTH_USER'],
            to:   @user.email,
            subject: '＜BugsCooking＞アカウント登録案内'
        ) do |format|
            format.text #テキストメールを指定
            #format.html #HTMLメールを指定
        end
    end

    # パスワードリマインダー案内
    def reset_password_mail(user)
        @user = user
        mail(
            from: ENV['MYAPP_MAIL_AUTH_USER'],
            to:   @user.email,
            subject: '＜BugsCooking＞パスワード再発行'
        ) do |format|
            format.text #テキストメールを指定
            #format.html #HTMLメールを指定
        end
    end
end
