#!/bin/bash

menu() {
    echo "+---------------------------------------------------------------------+"
    echo "|       Chào mừng bạn đến với tools của I_L0V3_P3T                    |"
    echo "+---------------------------------------------------------------------+"
    echo "| 1. Cài đặt và sử dụng web        |   2. Cài đặt và sử dụng PHP      |"
    echo "|----------------------------------|----------------------------------|"
    echo "| 3. Quản Lý user và Group         |   4. Cấu hình và sử dụng DNS     |"
    echo "|----------------------------------|----------------------------------|"
    echo "| 5. Cài đặt và sử dụng Mailserver |   6. Kien thuc Systemadmin Linux |"
    echo "|----------------------------------|----------------------------------|"
    echo "| 7. Quản lý máy in                |   8. Check Log                   |"
    echo "|----------------------------------|----------------------------------|"
    echo "| 9. Cài Đặt và sử dụng container  |   10. Tạo phân vùng              |"
    echo "|----------------------------------|----------------------------------|"
    echo "| 11. Lập lịch cho tác vụ          |   12. MySQL                      |"
    echo "+---------------------------------------------------------------------+"
    echo ""
    read -p "Vui lòng chọn một tùy chọn (1-12): " choice 
}
#################################################################
ham_main() {
   case $1 in
    1)

echo "Bạn đã chọn Cài đặt và sử dụng web."

Config_web() {
    echo "Chọn hành động bạn muốn thực hiện:"
    select action in "Kiểm tra dịch vụ" "Cài đặt dịch vụ" "Cấu hình dịch vụ" "Thoát"; do
        case $action in
            "Kiểm tra dịch vụ")
                echo "Chọn dịch vụ bạn muốn kiểm tra:"
                select web in "Apache" "Nginx" "Thoát"; do
                    case $REPLY in
                        1)
                            echo "Đang kiểm tra Apache..."
                            if apt list --installed | grep -qw "apache2"; then
                                echo "Apache đã được cài đặt."
                                if systemctl status apache2 >> /dev/null 2>&1; then
                                    echo "Dịch vụ Apache đang chạy."
                                else
                                    echo "Dịch vụ Apache không hoạt động."
                                fi
                            else
                                echo "Apache chưa được cài đặt."
                            fi
                            break
                            ;;
                        2)
                            echo "Đang kiểm tra Nginx..."
                            if apt list --installed | grep -qw "nginx"; then
                                echo "Nginx đã được cài đặt."
                                if systemctl status nginx >> /dev/null 2>&1; then
                                    echo "Dịch vụ Nginx đang chạy."
                                else
                                    echo "Dịch vụ Nginx không hoạt động."
                                fi
                            else
                                echo "Nginx chưa được cài đặt."
                            fi
                            break
                            ;;
                        3)
                            echo "Thoát khỏi kiểm tra."
                            break
                            ;;
                        *)
                            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                break
                ;;
            "Cài đặt dịch vụ")
                echo "Chọn dịch vụ bạn muốn cài đặt:"
                select web in "Apache" "Nginx" "Thoát"; do
                    case $REPLY in
                        1)
                            echo "Đang cài đặt Apache..."
                            sudo apt update -y >> /dev/null 2>&1
                            sudo apt upgrade -y >> /dev/null 2>&1
                            sudo apt install apache2 -y >> /dev/null 2>&1
                            systemctl restart apache2 >> /dev/null 2>&1
                            systemctl enable apache2 >> /dev/null 2>&1
                            systemctl start apache2 >> /dev/null 2>&1
                            echo "Apache đã được cài đặt và khởi động thành công!"
                            break
                            ;;
                        2)
                            echo "Đang cài đặt Nginx..."
                            sudo apt update -y >> /dev/null 2>&1
                            sudo apt upgrade -y >> /dev/null 2>&1
                            sudo apt install nginx -y >> /dev/null 2>&1
                            systemctl restart nginx >> /dev/null 2>&1
                            systemctl enable nginx >> /dev/null 2>&1
                            systemctl start nginx >> /dev/null 2>&1
                            echo "Nginx đã được cài đặt và khởi động thành công!"
                            break
                            ;;
                        3)
                            echo "Thoát khỏi cài đặt."
                            break
                            ;;
                        *)
                            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                break
                ;;
            "Cấu hình dịch vụ")
                echo "Chọn dịch vụ bạn muốn cấu hình:"
                select web in "Apache" "Nginx" "Thoát"; do
                    case $REPLY in
                        1)
                            echo "Chọn cách thức cấu hình Apache:"
                            select cautraloi1 in "Lấy file của tôi" "Tạo file sẵn" "Thoát"; do
                                case $cautraloi1 in
                                    1)
                                        read -p "Hãy nhập đường dẫn của bạn: " duongdan
                                        sudo cp "$duongdan" /var/www/html/
                                        sudo chown -R www-data:www-data /var/www/html/
                                        echo "Đang kiểm tra xem đã có file trong thư mục chứa..."
                                        ls -l /var/www/html
                                        break
                                        ;;
                                    2)
                                        echo "Đang tạo file index.html và style.css..."
                                        # Tạo file index.html
                                        sudo bash -c 'echo "<!DOCTYPE html>
                                        <html lang=\"vi\">
                                            <head>
                                                <meta charset=\"UTF-8\">
                                                <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
                                                <title>Trang Cá Nhân</title>
                                                <link rel=\"stylesheet\" href=\"style.css\">
                                            </head>
                                            <body>
                                                <header class=\"header\">
                                                    <div class=\"container\">
                                                        <h1 class=\"logo\">Xin Chào! Tôi Là <span>Nguyen Kim Binh</span></h1>
                                                        <p class=\"tagline\">Một người đam mê công nghệ và lập trình.</p>
                                                    </div>
                                                </header>
                                                <main class=\"content\">
                                                    <section class=\"about\">
                                                        <h2>Giới Thiệu</h2>
                                                       <p>Tôi không là ai cả, nhưng yêu thích học hỏi và khám phá những công nghệ mới.</p>
                                                    </section>
                                                    <section class=\"projects\">
                                                        <h2>Dự Án</h2>
                                                        <ul>
                                                            <li><a href=\"#\">Dự án 1: Trang web cá nhân</a></li>
                                                            <li><a href=\"#\">Dự án 2: Ứng dụng quản lý công việc</a></li>
                                                            <li><a href=\"#\">Dự án 3: Blog chia sẻ kiến thức lập trình</a></li>
                                                        </ul>
                                                    </section>
                                                </main>
                                                <footer class=\"footer\">
                                                    <p>Kết nối với tôi qua:
                                                        <a href=\"https://www.linkedin.com\" target=\"_blank\">LinkedIn</a> |
                                                       <a href=\"https://github.com\" target=\"_blank\">GitHub</a>
                                                    </p>
                                                </footer>
                                            </body>
                                        </html>" > /var/www/html/index.html'
                                        # Tạo file CSS
                                        sudo bash -c 'echo "body, h1, h2, p, ul, li, a {
                                            margin: 0;
                                            padding: 0;
                                            text-decoration: none;
                                            list-style: none;
                                        }

                                        body {
                                           font-family: \"Arial\", sans-serif;
                                            color: #333;
                                            line-height: 1.6;
                                            background: #f4f4f4;
                                        }

                                        .header {
                                            background: linear-gradient(45deg, #4facfe, #00f2fe);
                                            color: #fff;
                                            text-align: center;
                                            padding: 50px 20px;
                                        }

                                        .logo {
                                           font-size: 2.5em;
                                            margin-bottom: 10px;
                                        }

                                        .logo span {
                                            color: #ffeb3b;
                                        }

                                        .tagline {
                                            font-size: 1.2em;
                                        }

                                        .content {
                                            padding: 20px;
                                           max-width: 800px;
                                            margin: 0 auto;
                                            background: #fff;
                                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                                        }

                                        .footer {
                                            background: #333;
                                            color: #fff;
                                            text-align: center;
                                            padding: 10px 20px;
                                            margin-top: 20px;
                                        }

                                        .footer a 
                                            color: #4facfe;
                                            margin: 0 5px;
                                            transition: color 0.3s;
                                        }

                                        .footer a:hover {
                                            color: #00f2fe;
                                        }" > /var/www/html/style.css'
                                        echo "Đã tạo file index.html và style.css thành công!"
                                        break
                                        ;;
                                    3)
                                        echo "Thoát khỏi cấu hình."
                                        break
                                        ;;
                                    *)
                                        echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                        ;;
                                esac
                            done
                            break
                            ;;
                        2)
                            echo "Chọn cách thức cấu hình Nginx:"
                            select cautraloi1 in "Lấy file của tôi" "Tạo file sẵn" "Thoát"; do
                                case $cautraloi1 in
                                    1)
                                        read -p "Hãy nhập đường dẫn của bạn: " duongdan
                                        sudo cp "$duongdan" /var/www/html/
                                        sudo chown -R www-data:www-data /var/www/html/
                                        echo "Đang kiểm tra xem đã có file trong thư mục chứa..."
                                        ls -l /var/www/html
                                        break
                                        ;;
                                    2)
                                        echo "Đang tạo file index.html và style.css..."
                                        sudo bash -c 'echo "<!DOCTYPE html>
                                        <html lang=\"vi\">
                                            <head>
                                                <meta charset=\"UTF-8\">
                                                <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
                                                <title>Trang Cá Nhân</title>
                                                <link rel=\"stylesheet\" href=\"style.css\">
                                            </head>
                                            <body>
                                                <header class=\"header\">
                                                    <div class=\"container\">
                                                        <h1 class=\"logo\">Xin Chào! Tôi Là <span>Nguyen Kim Binh</span></h1>
                                                        <p class=\"tagline\">Một người đam mê công nghệ và lập trình.</p>
                                                    </div>
                                                </header>
                                                <main class=\"content\">
                                                    <section class=\"about\">
                                                        <h2>Giới Thiệu</h2>
                                                       <p>Tôi không là ai cả, nhưng yêu thích học hỏi và khám phá những công nghệ mới.</p>
                                                    </section>
                                                    <section class=\"projects\">
                                                        <h2>Dự Án</h2>
                                                        <ul>
                                                            <li><a href=\"#\">Dự án 1: Trang web cá nhân</a></li>
                                                            <li><a href=\"#\">Dự án 2: Ứng dụng quản lý công việc</a></li>
                                                            <li><a href=\"#\">Dự án 3: Blog chia sẻ kiến thức lập trình</a></li>
                                                        </ul>
                                                    </section>
                                                </main>
                                                <footer class=\"footer\">
                                                    <p>Kết nối với tôi qua:
                                                        <a href=\"https://www.linkedin.com\" target=\"_blank\">LinkedIn</a> |
                                                       <a href=\"https://github.com\" target=\"_blank\">GitHub</a>
                                                    </p>
                                                </footer>
                                            </body>
                                        </html>" > /var/www/html/index.html'
                                        sudo bash -c 'echo "body, h1, h2, p, ul, li, a {
                                            margin: 0;
                                            padding: 0;
                                            text-decoration: none;
                                            list-style: none;
                                        }

                                        body {
                                           font-family: \"Arial\", sans-serif;
                                            color: #333;
                                            line-height: 1.6;
                                            background: #f4f4f4;
                                        }

                                        .header {
                                            background: linear-gradient(45deg, #4facfe, #00f2fe);
                                            color: #fff;
                                            text-align: center;
                                            padding: 50px 20px;
                                        }

                                        .logo {
                                           font-size: 2.5em;
                                            margin-bottom: 10px;
                                        }

                                        .logo span {
                                            color: #ffeb3b;
                                        }

                                        .tagline {
                                            font-size: 1.2em;
                                        }

                                        .content {
                                            padding: 20px;
                                           max-width: 800px;
                                            margin: 0 auto;
                                            background: #fff;
                                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                                        }

                                        .footer {
                                            background: #333;
                                            color: #fff;
                                            text-align: center;
                                            padding: 10px 20px;
                                            margin-top: 20px;
                                        }

                                        .footer a 
                                            color: #4facfe;
                                            margin: 0 5px;
                                            transition: color 0.3s;
                                        }

                                        .footer a:hover {
                                            color: #00f2fe;
                                        }" > /var/www/html/style.css'
                                        echo "Đã tạo file index.html và style.css thành công!"
                                        break
                                        ;;
                                    3)
                                        echo "Thoát khỏi cấu hình."
                                        break
                                        ;;
                                    *)
                                        echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                        ;;
                                esac
                            done
                            break
                            ;;
                        3)
                            echo "Thoát khỏi cấu hình."
                            break
                            ;;
                        *)
                            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                break
                ;;
            "Thoát")
                echo "Thoát khỏi chương trình."
                exit 0
                ;;
            *)
                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                ;;
        esac
    done
}

# Kiểm tra quyền root
if [ "$(id -u)" -ne 0 ]; then
    echo "Bạn cần quyền root để chạy script này."
    exit 1
fi

Config_web
    ;;  
    2) 
       echo "Bạn đã chọn Cài đặt và sử dụng PHP"

config_php() {
    while true; do
        echo "Vui lòng chọn tác vụ cần thực hiện:"
        select action in "Cài đặt PHP" "Kiểm tra và nâng cấp PHP" "Kiểm tra XAMPP" "Kết nối và quản lý CSDL (XAMPP)" "Kiểm tra trạng thái dịch vụ Apache" "Thoát"; do
            case $action in
                "Cài đặt PHP")
                    echo "Đang kiểm tra cài đặt PHP..."
                    if dpkg -l | grep -qw "php"; then
                        echo "PHP đã được cài đặt."
                        if systemctl is-active --quiet php-fpm; then
                            echo "Dịch vụ PHP đang hoạt động."
                        else
                            echo "Dịch vụ PHP không hoạt động. Bạn có muốn khởi động không?"
                            read -p "Nhập 'y' để khởi động hoặc bất kỳ phím nào để bỏ qua: " start_php
                            if [ "$start_php" = "y" ]; then
                                sudo systemctl start php-fpm
                                echo "Dịch vụ PHP đã được khởi động."
                            fi
                        fi
                    else
                        echo "PHP chưa được cài đặt. Tiến hành cài đặt..."
                        sudo apt update -y && sudo apt install -y php php-fpm
                        echo "PHP đã được cài đặt thành công."
                    fi
                    break
                    ;;

                "Kiểm tra và nâng cấp PHP")
                    echo "Đang kiểm tra phiên bản PHP..."
                    if ! command -v php > /dev/null; then
                        echo "PHP chưa được cài đặt."
                    else
                        echo "Phiên bản hiện tại: $(php -v | head -n 1)"
                        echo "Bạn có muốn nâng cấp PHP không? (y/n)"
                        read upgrade_php
                        if [ "$upgrade_php" = "y" ]; then
                            sudo apt update -y && sudo apt upgrade -y php php-fpm
                            echo "PHP đã được nâng cấp thành công."
                        else
                            echo "Đã hủy nâng cấp PHP."
                        fi
                    fi
                    break
                    ;;

                "Kiểm tra XAMPP")
                    echo "Đang kiểm tra XAMPP..."
                    if [ -d "/opt/lampp" ]; then
                        echo "XAMPP đã được cài đặt."
                        echo "Kiểm tra thư mục htdocs..."
                        if [ -d "/opt/lampp/htdocs" ]; then
                            echo "Thư mục htdocs đã tồn tại."
                            read -p "Nhập tên thư mục muốn tạo trong htdocs: " folder_name
                            if [ -d "/opt/lampp/htdocs/$folder_name" ]; then
                                echo "Thư mục '$folder_name' đã tồn tại."
                            else
                                mkdir "/opt/lampp/htdocs/$folder_name"
                                echo "Thư mục '$folder_name' đã được tạo thành công."
                            fi
                        else
                            echo "Thư mục htdocs không tồn tại. Vui lòng kiểm tra lại cài đặt XAMPP!"
                        fi
                    else
                        echo "XAMPP chưa được cài đặt. Tiến hành tải về và cài đặt..."
                        wget -q https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.4/xampp-linux-x64-8.2.4-0-installer.run/download -O xampp-installer.run
                        chmod +x xampp-installer.run
                        sudo ./xampp-installer.run
                        echo "XAMPP đã được cài đặt thành công. Vui lòng kiểm tra lại các dịch vụ."
                    fi
                    break
                    ;;

                "Kết nối và quản lý CSDL (XAMPP)")
                    echo "Bạn muốn sử dụng giao diện hay lệnh để kết nối?"
                    select db_option in "Giao diện" "Lệnh"; do
                        case $db_option in
                            "Giao diện")
                                echo "Hãy truy cập: https://localhost/phpmyadmin để quản lý CSDL."
                                echo "Tại đây, bạn có thể tạo, chỉnh sửa, hoặc xóa bảng thông qua giao diện PHPMyAdmin."
                                break
                                ;;
                            "Lệnh")
                                read -p "Vui lòng nhập tên máy chủ (ví dụ: localhost): " server
                                read -p "Vui lòng nhập tên người dùng: " user
                                read -sp "Vui lòng nhập mật khẩu: " password
                                echo 
                                read -p "Vui lòng nhập tên cơ sở dữ liệu bạn muốn sử dụng: " database

                                echo "Đang kiểm tra kết nối..."
                                mysql -h "$server" -u "$user" -p"$password" -e "USE $database;" 2>/dev/null
                                if [ $? -eq 0 ]; then
                                    echo "Kết nối tới cơ sở dữ liệu thành công."
                                    echo "Bạn muốn thực hiện tác vụ nào?"
                                    select db_task in "Tạo bảng" "Chỉnh sửa bảng" "Xóa bảng" "Quay lại"; do
                                        case $db_task in
                                            "Tạo bảng")
                                                read -p "Nhập tên bảng muốn tạo: " table_name
                                                echo "Nhập cấu trúc các cột cho bảng (ví dụ: id INT PRIMARY KEY, name VARCHAR(100), age INT):"
                                                read -p "Cấu trúc cột: " columns
                                                mysql -h "$server" -u "$user" -p"$password" -e "CREATE TABLE $database.$table_name ($columns);" 2>/dev/null
                                                if [ $? -eq 0 ]; then
                                                    echo "Bảng '$table_name' đã được tạo thành công."
                                                else
                                                    echo "Không thể tạo bảng. Vui lòng kiểm tra cú pháp và thông tin."
                                                fi
                                                ;;
                                            "Chỉnh sửa bảng")
                                                read -p "Nhập tên bảng muốn chỉnh sửa: " table_name
                                                echo "Nhập câu lệnh SQL chỉnh sửa bảng (ví dụ: ALTER TABLE table_name ADD COLUMN email VARCHAR(100)):"
                                                read -p "Câu lệnh SQL: " alter_query
                                                mysql -h "$server" -u "$user" -p"$password" -e "$alter_query;" 2>/dev/null
                                                if [ $? -eq 0 ]; then
                                                    echo "Bảng '$table_name' đã được chỉnh sửa thành công."
                                                else
                                                    echo "Không thể chỉnh sửa bảng. Vui lòng kiểm tra câu lệnh SQL."
                                                fi
                                                ;;
                                            "Xóa bảng")
                                                read -p "Nhập tên bảng muốn xóa: " table_name
                                                echo "Bạn có chắc chắn muốn xóa bảng '$table_name'? Hành động này không thể hoàn tác! (y/n)"
                                                read confirm
                                                if [ "$confirm" = "y" ]; then
                                                    mysql -h "$server" -u "$user" -p"$password" -e "DROP TABLE $database.$table_name;" 2>/dev/null
                                                    if [ $? -eq 0 ]; then
                                                        echo "Bảng '$table_name' đã được xóa thành công."
                                                    else
                                                        echo "Không thể xóa bảng. Vui lòng kiểm tra thông tin."
                                                    fi
                                                else
                                                    echo "Hủy xóa bảng."
                                                fi
                                                ;;
                                            "Quay lại")
                                                break
                                                ;;
                                            *)
                                                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                                ;;
                                        esac
                                    done
                                else
                                    echo "Kết nối không thành công. Vui lòng kiểm tra lại thông tin."
                                fi
                                break
                                ;;
                            *)
                                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                ;;
                        esac
                    done
                    break
                    ;;

                "Kiểm tra trạng thái dịch vụ Apache")
                    echo "Đang kiểm tra trạng thái Apache..."
                    if systemctl is-active --quiet apache2; then
                        echo "Dịch vụ Apache đang hoạt động."
                    else
                        echo "Dịch vụ Apache không hoạt động. Bạn có muốn khởi động không?"
                        read -p "Nhập 'y' để khởi động hoặc bất kỳ phím nào để bỏ qua: " start_apache
                        if [ "$start_apache" = "y" ]; then
                            sudo systemctl start apache2
                            echo "Dịch vụ Apache đã được khởi động."
                        fi
                    fi
                    break
                    ;;

                "Thoát")
                    echo "Đã thoát khỏi chương trình."
                    break
                    ;;

                *)
                    echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                    ;;
            esac
        done
    done
}

config_php
        ;;
    3)
echo "Quản Lý User và Group"

config_usergroup() {
    while true; do
        echo "1. Quản lý User"
        echo "2. Quản lý Group"
        echo "3. Thoát"
        read -p "Vui lòng chọn (1-3): " choice_usergroup

        case $choice_usergroup in
            1)
                while true; do
                    echo "1. Tạo User"
                    echo "2. Xóa User"
                    echo "3. Nâng cấp User thành Super User"
                    echo "4. Quay lại"
                    read -p "Vui lòng chọn (1-4): " choice_user

                    case $choice_user in
                        1)
                            read -p "Nhập tên user cần tạo: " username
                            read -sp "Nhập mật khẩu của user: " password
                            echo
                            sudo useradd $username
                            if [ $? -eq 0 ]; then
                                echo "$username:$password" | sudo chpasswd
                                if [ $? -eq 0 ]; then
                                    echo "User đã được tạo thành công."
                                else
                                    echo "Có lỗi khi đặt mật khẩu cho user."
                                fi
                            else
                                echo "Có lỗi khi tạo user."
                            fi
                            ;;
                        2)
                            read -p "Nhập tên user cần xóa: " username
                            sudo userdel -r $username
                            if [ $? -eq 0 ]; then
                                echo "User đã được xóa thành công."
                            else
                                echo "Có lỗi khi xóa user."
                            fi
                            ;;
                        3)
                            read -p "Nhập tên user cần nâng cấp lên Super User: " username
                            sudo usermod -aG sudo $username
                            if [ $? -eq 0 ]; then
                                echo "User đã được nâng cấp lên Super User thành công."
                            else
                                echo "Có lỗi khi nâng cấp user."
                            fi
                            ;;
                        4)
                            break
                            ;;
                        *)
                            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                ;;
            2)
                while true; do
                    echo "1. Tạo Group"
                    echo "2. Xóa Group"
                    echo "3. Thêm User vào Group"
                    echo "4. Thay đổi quyền (chmod)"
                    echo "5. Chuyển sở hữu (chown)"
                    echo "6. Quay lại"
                    read -p "Vui lòng chọn (1-6): " choice_group

                    case $choice_group in
                        1)
                            read -p "Nhập tên group cần tạo: " groupname
                            sudo groupadd $groupname
                            if [ $? -eq 0 ]; then
                                echo "Group đã được tạo thành công."
                            else
                                echo "Có lỗi khi tạo group."
                            fi
                            ;;
                        2)
                            read -p "Nhập tên group cần xóa: " groupname
                            sudo groupdel $groupname
                            if [ $? -eq 0 ]; then
                                echo "Group đã được xóa thành công."
                            else
                                echo "Có lỗi khi xóa group."
                            fi
                            ;;
                        3)
                            read -p "Nhập tên user cần thêm vào group: " username
                            read -p "Nhập tên group cần thêm user vào: " groupname
                            sudo usermod -aG $groupname $username
                            if [ $? -eq 0 ]; then
                                echo "User đã được thêm vào group thành công."
                            else
                                echo "Có lỗi khi thêm user vào group."
                            fi
                            ;;
                        4)
                            read -p "Nhập đường dẫn file cần thay đổi quyền: " filepath
                            read -p "Nhập quyền (vd: 755): " permission
                            sudo chmod $permission $filepath
                            if [ $? -eq 0 ]; then
                                echo "Quyền đã được thay đổi thành công."
                            else
                                echo "Có lỗi khi thay đổi quyền."
                            fi
                            ;;
                        5)
                            read -p "Nhập đường dẫn file cần chuyển sở hữu: " filepath
                            read -p "Nhập tên user cần làm chủ sở hữu: " username
                            sudo chown $username $filepath
                            if [ $? -eq 0 ]; then
                                echo "Chủ sở hữu đã được thay đổi thành công."
                            else
                                echo "Có lỗi khi thay đổi chủ sở hữu."
                            fi
                            ;;
                        6)
                            break
                            ;;
                        *)
                            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                ;;
            3)
                echo "Thoát chương trình."
                exit 0
                ;;
            *)
                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                ;;
        esac
    done
}

config_usergroup
;;
   4)
config_dns() {
    echo "Chọn một tùy chọn:"
    echo "1) Hướng dẫn về DNS"
    echo "2) Cài đặt va thiết lập DNS server"
    echo "3) Thoát"
    read -p "Nhập lựa chọn của bạn: " choice

    case $choice in
        1)
            echo "DNS là gì? Cách hoạt động"
            echo "DNS (Domain Name System) là hệ thống máy chủ dịch tên miền, giúp thay thế các địa chỉ IP phức tạp bằng các tên miền dễ nhớ. Khi bạn truy cập một trang web (ví dụ: facebook.com), quy trình hoạt động của DNS sẽ như sau:"
            echo "1. Truy vấn từ trình duyệt."
            echo "2. Truy vấn tới Resolver Server."
            echo "3. Truy vấn tới DNS Root Server."
            echo "4. Truy vấn tới TLD Server (Top Level Domain)."
            echo "5. Truy vấn tới Authoritative Name Server."
            echo "Cuối cùng, DNS trả về địa chỉ IP cho trình duyệt của bạn."
            ;;
        2)

      apt update -y >/dev/null 2>&1
            echo "Configuring a domain name for your system..."
                host_name=$(hostname | awk -F"." '{print $1}')
            echo "Enter a new domain name for your system: "
                read -r domain_name
                if [[ -z "$domain_name" ]]; then
            echo "Error: Domain name cannot be empty."
                exit 1
                fi

               fqdn="${host_name}.${domain_name}"
              echo "Opening /etc/hostname for manual editing..."
                sudo nano /etc/hostname
                echo "$fqdn" | sudo tee /etc/hostname >/dev/null
                fqdomain_name=$(cat /etc/hostname)
                 echo "The fully qualified domain name (FQDN) has been updated to: $fqdomain_name"
                 echo "Changes saved in /etc/hostname." 

             echo "The fully qualified domain name (FQDN) has been updated to: $fqdn"
             echo "The hostname stored in /etc/hostname: $(cat /etc/hostname)"
             echo "Current system hostname: $fqdomain_name"
             echo "Contents of /etc/hosts:"
             cat /etc/hosts


             echo " Assign the configuration files to variables... "
                    named_file="/etc/bind/named.conf"
                    forward_file="/var/cache/bind/forward.$domain_name"
                    reverse_file="/var/cache/bind/reverse.$domain_name"

             echo ' List the available network interfaces...'
                    net_int=$(ip -o link show | awk -F': ' '{print $2}')
                    echo $net_int
                    echo 'Enter the network interface to configure the DNS server with: '
                    read -r net_int_name

             echo " Assign IP addresses to variables..."
                   net_int_ip=$(ifconfig $net_int_name | awk -F' ' 'FNR == 2 {print $2}')
                   echo "${net_int_ip} ${fqdomain_name}" >> /etc/hosts
                   oct_1=$(echo $net_int_ip | cut -d"." -f1)
                   oct_2=$(echo $net_int_ip | cut -d"." -f2)
                   oct_3=$(echo $net_int_ip | cut -d"." -f3)
                   oct_4=$(echo $net_int_ip | cut -d"." -f4)
                   first_3_oct_reverse="${oct_3}.${oct_2}.${oct_1}"
                   desktop_ip="${oct_1}.${oct_2}.${oct_3}.$(expr $oct_4 - 1)"

             echo " Install the packages for the DNS server..."
                   apt install -y bind9 bind9utils bind9-doc >/dev/null 2>&1

             echo " Configure the “named” server configuration file with the IP address at line 13."
                   sed -i "13s/^\(.\{32\}\)/\1$net_int_ip; /" $named_file

             echo " Enable a firewall rule that permits DNS traffic. "
                   ufw allow 53/tcp
                   ufw allow 53/udp

             echo " Enable, start and verify the status of the “named” server. "
                   systemctl enable bind9 >/dev/null 2>&1
                   systemctl start bind9 >/dev/null 2>&1
                   systemctl status bind9 --no-pager >/dev/null 2>&1
 
             echo " Configure a primary zone for the DNS server..."
                   sed -i '59s/^/\n\n\n\n\n\n\n\n\n\n\n\n/' $named_file
                   sed -i '59s/^/zone "/' $named_file
                   sed -i "59s/^/$domain_name/ $named_file"
                   sed -i '59s/^/ IN {/' $named_file
                   sed -i '60s/^/\t type master;/' $named_file
                   sed -i '61s/^/ \t file "forward./' $named_file
                   sed -i "61s/^/$domain_name/ $named_file"
                   sed -i '61s/^/ \t file "forward./' $named_file
                   sed -i '62s/^/ \t allow-update { none; };/ $named_file'
                   sed -i '63s/^/};/' $named_file

             echo " Configure a reverse lookup zone for the DNS server. "
                   sed -i '65s/^/.in-addr.arpa" IN {/' $named_file
                   sed -i "65s/^/$first_3_oct_reverse/ $named_file"
                   sed -i '65s/^/zone "/' $named_file
                   sed -i '66s/^/\t type master;/' $named_file
                   sed -i '67s/^/ \t file "reverse./' $named_file
                   sed -i "67s/^/$domain_name/ $named_file"
                   sed -i '67s/^/ \t file "reverse./' $named_file
                   sed -i '68s/^/ \t allow-update { none; };/ $named_file'
                   sed -i '69s/^/};/' $named_file

             echo " Configure the DNS server’s forward zone file..."
                   cp /etc/bind/db.local $forward_file
                   sed -i -e "2s/@ rname.invalid/${domain_name}. root.$domain_name/" $forward_file
                   for i in $(seq 1 3)
                     do
                       sed -i '$d' $forward_file
                     done


              echo "
                   @ IN NS $domain_name.
                   @ IN A $net_int_ip
                   server IN A $net_int_ip
                   host IN A $net_int_ip
                   desktop IN A $desktop_ip
                   client IN A $desktop_ip" >> $forward_file

              echo "Configure the reverse zone file."
                   cp $forward_file $reverse_file
                   sed -i -e "10s/A/PTR/;10s/${net_int_ip}/${domain_name}./" $reverse_file
              echo "11 IN PTR server.$domain_name.
                   10 IN PTR desktop.$domain_name." >> $reverse_file

              echo " Configure the ownership of the forward and reverse zone files."
                   chown root:bind $forward_file
                   chown root:bind $reverse_file

             echo " Verify the validity of the DNS server’s configuration files."
                   named-checkconf -z $named_file
                   named-checkzone forward $forward_file
                   named-checkzone reverse $reverse_file 
             echo " Restart the DNS server. "
                    systemctl restart bind9 >/dev/null 2>&1
                 ;;
        3)
            echo "Thoát khỏi chương trình."
            exit 0
            ;;
        *)
            echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
            ;;
    esac
}
config_dns
   ;;
    5)
        echo "Bạn đã chọn Cài đặt và sử dụng Mailserver."
        config_Mailserver
        ;;
    6)
        echo " Kien thuc System administration Linux"
        ;;
    7)
        echo "Bạn đã chọn Quản lý máy in."
        config_printter
        ;;
    8)
echo "Bạn đã chọn Check Log."

config_checklog () {
   LOG_FILE="/var/log/syslog"
   DATE=$(date "+%Y-%m-%d_%H-%M-%S")
   OUTPUT_LOG="/var/log/log_classified_$DATE.log"

     if [ ! -f "$LOG_FILE" ]; then
        echo "Error: Log file $LOG_FILE not found."
        exit 1
   fi
   awk '{
         if ($0 ~ /gnome-shell/) {
           TIME=$1 " " $2 " " $3
           PROC_NAME=$5
           EVENT_NAME=substr($0, index($0, $6))

           # Ghi vào file phân loại log
           printf "| %-19s | %-24s | %-35s |\n", TIME, PROC_NAME, EVENT_NAME
       } else {
           # Nếu không phải gnome-shell, ghi nguyên văn
           print $0
       }
   }' "$LOG_FILE" >> "$OUTPUT_LOG"

   
   echo "Log đã phân loại lưu tại: $OUTPUT_LOG"
   cat "$OUTPUT_LOG"

      echo "Displaying the last 50 lines of $LOG_FILE:"
   tail -n 50 "$LOG_FILE"

   echo "Script completed successfully."
}

config_checklog
  
        ;;
    9)
        echo "Bạn đã chọn Cài Đặt và sử dụng container."
        config_container() {

if ! command -v docker &> /dev/null
then
    echo "Docker chưa được cài đặt. Vui lòng cài đặt Docker trước khi sử dụng script này."
    exit 1
fi

echo "Docker đã được cài đặt. Chúng ta sẽ bắt đầu làm việc với container!"


echo "Chọn hành động bạn muốn thực hiện với Docker:"
echo "1. Tạo một container mới từ image."
echo "2. Hiển thị danh sách các container đang chạy."
echo "3. Dừng một container đang chạy."
echo "4. Xóa một container."
echo "5. Tạo container và mở một terminal bên trong."


read -p "Nhập lựa chọn (1-5): " choice

case $choice in
    1)
        
        echo "Nhập tên image bạn muốn sử dụng (ví dụ: ubuntu, nginx, mysql):"
        read -r image_name
        echo "Nhập tên cho container mới của bạn:"
        read -r container_name
        echo "Đang tạo container từ image $image_name với tên $container_name..."
        docker run -d --name "$container_name" "$image_name"
        echo "Container $container_name đã được tạo từ image $image_name."
        ;;
    2)
        
        echo "Danh sách các container đang chạy:"
        docker ps
        ;;
    3)
        
        echo "Nhập tên hoặc ID của container cần dừng:"
        read -r container_name
        echo "Đang dừng container $container_name..."
        docker stop "$container_name"
        echo "Container $container_name đã dừng."
        ;;
    4)
       
        echo "Nhập tên hoặc ID của container cần xóa:"
        read -r container_name
        echo "Đang xóa container $container_name..."
        docker rm "$container_name"
        echo "Container $container_name đã bị xóa."
        ;;
    5)
        echo "Nhập tên image bạn muốn sử dụng để tạo container (ví dụ: ubuntu, nginx):"
        read -r image_name
        echo "Nhập tên cho container của bạn:"
        read -r container_name
        echo "Tạo container và mở terminal bên trong container..."
        docker run -it --name "$container_name" "$image_name" bash
        ;;
    *)
        echo "Lựa chọn không hợp lệ. Vui lòng chọn lại từ 1 đến 5."
        ;;
esac

echo "Đã hoàn thành tác vụ Docker của bạn!"
        }
        config_container
        ;;
        
    10)
        echo "Bạn đã chọn Tạo phân vùng."
        config_LVM() {


         if [[ $(id -u) -ne 0 ]]; then
           echo "Bạn cần quyền sudo để chạy script này."
           exit 1
         fi

           echo "Quản lý LVM - Logical Volume Management"

           echo "Chọn hành động bạn muốn thực hiện với LVM:"
           echo "1. Tạo một Physical Volume (PV)."
           echo "2. Tạo một Volume Group (VG)."
           echo "3. Tạo một Logical Volume (LV)."
           echo "4. Hiển thị thông tin LVM hiện tại."
           echo "5. Xóa Logical Volume (LV)."
           echo "6. Xóa Volume Group (VG)."
           echo "7. Xóa Physical Volume (PV)."

           read -p "Nhập lựa chọn (1-7): " choice

case $choice in
    1)
        echo "Nhập tên thiết bị cần tạo PV (ví dụ: /dev/sdb):"
        read -r pv_device
        echo "Đang tạo PV trên thiết bị $pv_device..."
        sudo pvcreate "$pv_device"
        echo "PV đã được tạo trên $pv_device."
        ;;
    2)
        echo "Nhập tên Volume Group (VG) bạn muốn tạo:"
        read -r vg_name
        echo "Nhập tên thiết bị hoặc Physical Volume (PV) cần thêm vào VG:"
        read -r pv_device
        echo "Đang tạo VG $vg_name với PV $pv_device..."
        sudo vgcreate "$vg_name" "$pv_device"
        echo "Volume Group $vg_name đã được tạo."
        ;;
    3)
        echo "Nhập tên Volume Group (VG) để tạo LV:"
        read -r vg_name
        echo "Nhập tên Logical Volume (LV) bạn muốn tạo:"
        read -r lv_name
        echo "Nhập kích thước của LV (ví dụ: 10G):"
        read -r lv_size
        echo "Đang tạo LV $lv_name trong VG $vg_name với kích thước $lv_size..."
        sudo lvcreate -L "$lv_size" -n "$lv_name" "$vg_name"
        echo "Logical Volume $lv_name đã được tạo."
        ;;
    4)
        echo "Hiển thị thông tin PV, VG, LV:"
        sudo pvs
        sudo vgs
        sudo lvs
        ;;
    5)
        echo "Nhập tên Logical Volume (LV) cần xóa:"
        read -r lv_name
        echo "Nhập tên Volume Group (VG) chứa LV:"
        read -r vg_name
        echo "Đang xóa LV $lv_name trong VG $vg_name..."
        sudo lvremove "/dev/$vg_name/$lv_name"
        echo "Logical Volume $lv_name đã bị xóa."
        ;;
    6)
        echo "Nhập tên Volume Group (VG) cần xóa:"
        read -r vg_name
        echo "Đang xóa VG $vg_name..."
        sudo vgremove "$vg_name"
        echo "Volume Group $vg_name đã bị xóa."
        ;;
    7)
        echo "Nhập tên Physical Volume (PV) cần xóa:"
        read -r pv_device
        echo "Đang xóa PV $pv_device..."
        sudo pvremove "$pv_device"
        echo "Physical Volume $pv_device đã bị xóa."
        ;;
    *)
        echo "Lựa chọn không hợp lệ. Vui lòng chọn lại từ 1 đến 7."
        ;;
esac

echo "Hoàn thành tác vụ LVM!"
        }
        config_LVM
        ;;
    11)
        echo "Bạn đã chọn Lập lịch cho tác vụ."
        config_tasks () {

          if [ "$EUID" -ne 0 ]; then
              echo "Vui lòng chạy script với quyền sudo."
          exit 1
          fi

         echo "Đây là script tạo crontab tự động."
         echo "--------------------------------------"
         echo "Hướng dẫn:"
         echo "1. Lệnh cron sẽ được chạy vào thời gian bạn chỉ định."
         echo "2. Bạn cần cung cấp đường dẫn đầy đủ tới file script và thời gian chạy."
         echo "3. Kết quả sẽ được ghi vào một file log."

         echo "--------------------------------------"
         echo "Định dạng thời gian cho cronjob:"
         echo "Phần đầu tiên là 'phút', có giá trị từ 0 đến 59."
         echo "Phần thứ hai là 'giờ', có giá trị từ 0 đến 23."
         echo "Phần thứ ba là 'ngày trong tháng', có giá trị từ 1 đến 31."
         echo "Phần thứ tư là 'tháng', có giá trị từ 1 đến 12."
         echo "Phần cuối cùng là 'ngày trong tuần', có giá trị từ 0 đến 6 (0 là Chủ nhật)."
         echo ""
         echo "Ví dụ:"
         echo "  '0 7 * * 1-5' sẽ chạy cronjob vào lúc 7:00 sáng từ thứ Hai đến thứ Sáu."
         echo "  '30 2 1 * *' sẽ chạy cronjob vào lúc 2:30 sáng vào ngày 1 của mỗi tháng."
         echo "  '* * * * *' sẽ chạy cronjob mỗi phút."

         echo -n "Nhập đường dẫn đầy đủ tới file script của bạn (ví dụ: /home/user/script.sh): "
            read -r script_path

         if [ ! -f "$script_path" ]; then
            echo "Lỗi: File script không tồn tại. Vui lòng kiểm tra lại đường dẫn."
            exit 1
         fi


         echo -n "Nhập phút cho cronjob (0-59, ví dụ: 0): "
         read -r minute
         echo -n "Nhập giờ cho cronjob (0-23, ví dụ: 7): "
         read -r hour

         echo -n "Nhập ngày trong tháng cho cronjob (1-31, ví dụ: 7), hoặc nhấn Enter để không chọn: "
         read -r day_of_month

         if [ -z "$day_of_month" ]; then
         day_of_month="*"
         fi

         echo -n " Nhập tháng cho cronjob (1-12, ví dụ: 5): "
         read -r month

         echo -n "Nhập ngày trong tuần cho cronjob (0-6, ví dụ: 1 cho thứ Hai), hoặc nhấn Enter để không chọn: "
         read -r day_of_week

         if [ -z "$day_of_week" ]; then
         day_of_week="*"
         fi

         if ! [[ "$minute" =~ ^[0-9]{1,2}$ ]] || [ "$minute" -gt 59 ]; then
         echo "Lỗi: Phút không hợp lệ. Vui lòng nhập lại."
         exit 1
         fi

         if ! [[ "$hour" =~ ^[0-9]{1,2}$ ]] || [ "$hour" -gt 23 ]; then
          echo "Lỗi: Giờ không hợp lệ. Vui lòng nhập lại."
          exit 1
         fi
         if ! [[ "$month" =~ ^[0-9]{1,2}$ ]] || [ "$month" -gt 12 ]; then
           echo "Lỗi: Tháng không hợp lệ. Vui lòng nhập lại."
           exit 1
         fi        
         if ! [[ "$day_of_month" =~ ^[0-9]{1,2}$ ]] && [ "$day_of_month" != "*" ]; then
            echo "Lỗi: Ngày trong tháng không hợp lệ. Vui lòng nhập lại."
            exit 1
         fi
         if ! [[ "$day_of_week" =~ ^[0-9]{1,2}$ ]] && [ "$day_of_week" != "*" ]; then
         echo "Lỗi: Ngày trong tuần không hợp lệ. Vui lòng nhập lại."
         exit 1
         fi

         echo -n "Nhập đường dẫn đầy đủ tới file log (ví dụ: /home/user/log.txt): "
         read -r log_file

         if [ ! -f "$log_file" ]; then
          echo "File log không tồn tại. Tạo mới file log tại: $log_file"
          touch "$log_file"
         fi

          cronjob="$minute $hour $day_of_month $month $day_of_week $script_path >> $log_file 2>&1"

          (crontab -l 2>/dev/null; echo "$cronjob") | crontab -

         if [ $? -eq 0 ]; then
           echo "Cronjob đã được thêm thành công vào crontab."
           echo "Cronjob: $cronjob"
         else
           echo "Có lỗi xảy ra khi thêm cronjob vào crontab."
           exit 1
         fi

           echo "--------------------------------------"
           echo "Danh sách cronjob hiện tại:"
           crontab -l

        }
config_tasks
        ;;
    12)
        echo "Mysql"
        config_mysql
        ;;
    *)
        echo "Lựa chọn không hợp lệ. Vui lòng thử lại."
        ;;
   esac
}


while true; do 
    menu
    ham_main "$choice"
    read -p "Bạn có muốn tiếp tục không : y or n ? " continue_choice
    if [[ "$continue_choice" != "y" ]]; then
        echo "Cảm ơn bạn đã sử dụng tools của 1_L0V3_P3T."
        exit
    else 
        clear
    fi
done

#them phan dns phu vao dns chinh bang tranfer va cau tao them DNS phu nua va chinh sua sang tieng Viet 




