#!/bin/bash

menu() {
    echo "+-----------------------------------------------------------------+"
    echo "|       Chào mừng bạn đến với tools của I_L0V3_P3T                  |"
    echo "+-----------------------------------------------------------------+"
    echo "| 1. Cài đặt và sử dụng web        |   2. Cài đặt và sử dụng PHP  |"
    echo "|----------------------------------|------------------------------|"
    echo "| 3. Quản Lý user và Group         |   4. Cấu hình và sử dụng DNS |"
    echo "|----------------------------------|------------------------------|"
    echo "| 5. Cài đặt và sử dụng Mailserver |   6. Giám sát                |"
    echo "|----------------------------------|------------------------------|"
    echo "| 7. Quản lý máy in                |   8. Check Log               |"
    echo "|----------------------------------|------------------------------|"
    echo "| 9. Cài Đặt và sử dụng container  |   10. Tạo phân vùng          |"
    echo "|----------------------------------|------------------------------|"
    echo "| 11. Lập lịch cho tác vụ          |   12. MySQL                  |"
    echo "+-----------------------------------------------------------------+"
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
                                echo # Xuống dòng sau khi nhập mật khẩu
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
        echo "Quản Lý user và Group ."
        config_usergroup() {
    echo "Bạn đã chọn mục quản lý user và group..."
    echo "Vui lòng chọn User hay Group để tác động:"
    select usergroup in "User" "Group" "Thoát"; do
        case $usergroup in
            "User")
                echo "Bạn đã chọn quản lý User. Vui lòng chọn tác vụ:"
                select action in "Tạo User" "Xóa User" "Nâng cấp User thành Super User" "Thoát"; do
                    case $action in
                        "Tạo User")
                            read -p "Nhập tên user cần tạo: " username
                            read -sp "Nhập mật khẩu của user: " password
                            echo
                            sudo useradd $username -p $(openssl passwd -crypt $password)
                            if [ $? -eq 0 ]; then
                                echo "User đã được tạo thành công."
                            else
                                echo "Có lỗi khi tạo user."
                            fi
                            break
                            ;;
                        "Xóa User")
                            read -p "Nhập tên user cần xóa: " username
                            sudo userdel -r $username
                            if [ $? -eq 0 ]; then
                                echo "User đã được xóa thành công."
                            else
                                echo "Có lỗi khi xóa user."
                            fi
                            break
                            ;;
                        "Nâng cấp User thành Super User")
                            read -p "Nhập tên user cần nâng cấp lên Super User: " username
                            sudo usermod -aG sudo $username
                            if [ $? -eq 0 ]; then
                                echo "User đã được nâng cấp lên Super User thành công."
                            else
                                echo "Có lỗi khi nâng cấp user."
                            fi
                            break
                            ;;
                        "Thoát")
                            break
                            ;;
                        *)
                            echo "Chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                ;;
            "Group")
                echo "Bạn đã chọn quản lý Group. Vui lòng chọn tác vụ:"
                select action in "Tạo Group" "Xóa Group" "Thêm User vào Group" "Thay đổi quyền (chmod)" "Chuyển sở hữu (chown)" "Thoát"; do
                    case $action in
                        "Tạo Group")
                            read -p "Nhập tên group cần tạo: " groupname
                            sudo groupadd $groupname
                            if [ $? -eq 0 ]; then
                                echo "Group đã được tạo thành công."
                            else
                                echo "Có lỗi khi tạo group."
                            fi
                            break
                            ;;
                        "Xóa Group")
                            read -p "Nhập tên group cần xóa: " groupname
                            sudo groupdel $groupname
                            if [ $? -eq 0 ]; then
                                echo "Group đã được xóa thành công."
                            else
                                echo "Có lỗi khi xóa group."
                            fi
                            break
                            ;;
                        "Thêm User vào Group")
                            read -p "Nhập tên user cần thêm vào group: " username
                            read -p "Nhập tên group cần thêm user vào: " groupname
                            sudo usermod -aG $groupname $username
                            if [ $? -eq 0 ]; then
                                echo "User đã được thêm vào group thành công."
                            else
                                echo "Có lỗi khi thêm user vào group."
                            fi
                            break
                            ;;
                        "Thay đổi quyền (chmod)")
                            read -p "Nhập đường dẫn file cần thay đổi quyền: " filepath
                            read -p "Nhập quyền (vd: 755): " permission
                            sudo chmod $permission $filepath
                            if [ $? -eq 0 ]; then
                                echo "Quyền đã được thay đổi thành công."
                            else
                                echo "Có lỗi khi thay đổi quyền."
                            fi
                            break
                            ;;
                        "Chuyển sở hữu (chown)")
                            read -p "Nhập đường dẫn file cần chuyển sở hữu: " filepath
                            read -p "Nhập tên user cần làm chủ sở hữu: " username
                            sudo chown $username $filepath
                            if [ $? -eq 0 ]; then
                                echo "Chủ sở hữu đã được thay đổi thành công."
                            else
                                echo "Có lỗi khi thay đổi chủ sở hữu."
                            fi
                            break
                            ;;
                        "Thoát")
                            break
                            ;;
                        *)
                            echo "Chọn không hợp lệ. Vui lòng chọn lại."
                            ;;
                    esac
                done
                ;;
            "Thoát")
                return
                ;;
            *)
                echo "Chọn không hợp lệ. Vui lòng chọn lại."
                ;;
        esac
    done
}
        ;;
   4)

    config_dns() {
    echo "Chọn một tùy chọn:"
    echo "1) Hướng dẫn về DNS"
    echo "2) Cài đặt DNS server"
    echo "3) Thêm tên miền"
    echo "4) Xóa tên miền"
    echo "5) Thoát"
    read -p "Nhập lựa chọn của bạn: " choice

    case $choice in
    1)
        echo "DNS là gì? Cách hoạt động"
        echo "DNS (Domain Name System) là hệ thống máy chủ dịch tên miền, giúp thay thế các địa chỉ IP phức tạp bằng các tên miền dễ nhớ. Khi bạn truy cập một trang web (ví dụ: facebook.com), quy trình hoạt động của DNS sẽ như sau:

Truy vấn từ trình duyệt:
Trình duyệt của bạn sẽ kiểm tra bộ nhớ đệm (cache) cục bộ trên máy tính để tìm địa chỉ IP của tên miền.

Truy vấn tới Resolver Server:
Nếu không tìm thấy trong bộ nhớ đệm, yêu cầu sẽ được gửi đến Resolver Server, thường do nhà cung cấp dịch vụ Internet (ISP) quản lý. Máy chủ này kiểm tra bộ nhớ cache của mình và nếu không có, nó sẽ tiếp tục truy vấn các cấp cao hơn.

Truy vấn tới DNS Root Server:
Nếu Resolver Server không có thông tin, nó sẽ gửi truy vấn đến Root Server. Đây là hệ thống máy chủ tên miền gốc (13 root server trên toàn thế giới), chịu trách nhiệm xử lý các tên miền cấp cao như .com, .org, .vn,...

Truy vấn tới TLD Server (Top Level Domain):
Sau khi xác định được miền cấp cao (ví dụ .com), truy vấn sẽ được chuyển đến TLD Server tương ứng, nơi lưu thông tin về tên miền cấp hai như facebook.com.

Truy vấn tới Authoritative Name Server:
Cuối cùng, truy vấn sẽ được gửi tới Authoritative Name Server, là nơi lưu trữ thông tin chính xác về địa chỉ IP của facebook.com. Máy chủ này trả về địa chỉ IP cho Resolver Server, và kết quả được gửi đến trình duyệt của bạn."
        ;;
    2)
        echo "Cập nhật hệ thống và cài đặt bind9..."
        sudo apt update
        if ! dpkg -l | grep -qw bind9; then
            sudo apt install -y bind9 >> /dev/null 2>&1
        else
            echo "bind9 đã được cài đặt."
        fi
        echo "Cài đặt DNS server hoàn tất!"
        ;;
    3)
        read -p "Nhập tên miền (e.g., example.com): " domain_name
        read -p "Nhập địa chỉ IP máy chủ (e.g., 192.168.1.1): " ip
        zone_file="/etc/bind/db.$domain_name"
        echo "Tạo file cấu hình zone tại $zone_file..."
        sudo bash -c "cat > $zone_file <<EOF
\$TTL    604800
@       IN      SOA     ns1.$domain_name. admin.$domain_name. (
                          1         ; Serial
                          604800    ; Refresh
                          86400     ; Retry
                          2419200   ; Expire
                          604800 )  ; Negative Cache TTL
;
@       IN      NS      ns1.$domain_name.
ns1     IN      A       $ip
@       IN      A       $ip
EOF"
        sudo bash -c "cat >> /etc/bind/named.conf.local <<EOF
zone \"$domain_name\" {
    type master;
    file \"/etc/bind/db.$domain_name\";
};
EOF"
        sudo named-checkzone $domain_name $zone_file
        sudo systemctl restart bind9
        echo "Đã thêm cấu hình tên miền $domain_name thành công!"
        ;;
    4)
        read -p "Nhập tên miền muốn xóa (e.g., example.com): " domain_name
        zone_file="/etc/bind/db.$domain_name"
        if [ -f "$zone_file" ]; then
            echo "Xóa file zone $zone_file..."
            sudo rm -f "$zone_file"
            sudo sed -i "/zone \"$domain_name\" {/,/};/d" /etc/bind/named.conf.local
            sudo systemctl restart bind9
            echo "Đã xóa cấu hình tên miền $domain_name."
        else
            echo "Tên miền $domain_name không tồn tại!"
        fi
        ;;
    5)
        echo "Thoát chương trình."
        exit 0
        ;;
    *)
        echo "Lựa chọn không hợp lệ!"
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
        echo "Bạn đã chọn Giám sát."
        config_giamsat
        ;;
     7)
        echo "Bạn đã chọn Quản lý máy in."
        config_printter
        ;;
    8)
        echo "Bạn đã chọn Check Log."
        config_checklog
        ;;
    9)
        echo "Bạn đã chọn Cài Đặt và sử dụng container."
        config_container
        ;;
    10)
        echo "Bạn đã chọn Tạo phân vùng."
        config_LVM
        ;;
    11)
        echo "Bạn đã chọn Lập lịch cho tác vụ."
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

#Return or exit program
while true; do 
    # Display menu
    menu
    ham_main "$choice"
    
    # Prompt the user for continuation
    read -p "Bạn có muốn tiếp tục không : y or n ? " continue_choice
    # Check the user's response
    if [[ "$continue_choice" != "y" ]]; then
        echo "Cảm ơn bạn đã sử dụng tools của 1_L0V3_P3T."
        exit
    else 
        clear
    fi
done



