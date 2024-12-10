#!/bin/bash

menu() {
    echo "+----------------------------------------------------------------------------+"
    echo "|              Chào mừng bạn đến với tools của I_L0V3_P3T                    |"
    echo "+----------------------------------------------------------------------------+"
    echo "| 1. Cài đặt và sử dụng web        |   2. Cài đặt và sử dụng PHP + XAMPP     |"
    echo "|----------------------------------|-----------------------------------------|"
    echo "| 3. Quản Lý user và Group         |   4. Cấu hình và sử dụng DNS            |"
    echo "|----------------------------------|-----------------------------------------|"
    echo "| 5. Cài đặt và sử dụng Mailserver |   6. Kiến Thức SystemAdmin Linux        |"
    echo "|----------------------------------|-----------------------------------------|"
    echo "| 7. Quản lý máy in                |   8. Check Log                          |"
    echo "|----------------------------------|-----------------------------------------|"
    echo "| 9. Cài Đặt và sử dụng container  |   10. Tạo phân vùng                     |"
    echo "|----------------------------------|-----------------------------------------|"
    echo "| 11. Lập lịch cho tác vụ          |   12. Cài đặt và sử dụng  SQL Server    |"
    echo "+----------------------------------------------------------------------------+"
    echo ""
    read -p "Vui lòng chọn một tùy chọn (1-12): " choice 
}
#################################################################
ham_main() {
   case $1 in
    1)
            echo "Bạn đã chọn Cài đặt và sử dụng web."

           check_root() {
               if [ "$(id -u)" -ne 0 ]; then
                   echo "Bạn cần quyền root để chạy script này."
                   exit 1
               fi
}

           check_service() {
               local service=$1
               echo "Đang kiểm tra $service..."
               if apt list --installed | grep -qw "$service"; then
                    echo "$service đã được cài đặt."
               if systemctl status "$service" >> /dev/null 2>&1; then
                    echo "Dịch vụ $service đang chạy."
               else
                    echo "Dịch vụ $service không hoạt động."
                fi
               else
                    echo "$service chưa được cài đặt."
                fi
}

           install_service() {
               local service=$1
               echo "Đang cài đặt $service..."
               sudo apt update -y >> /dev/null 2>&1
               sudo apt upgrade -y >> /dev/null 2>&1
               sudo apt install "$service" -y >> /dev/null 2>&1
               systemctl restart "$service" >> /dev/null 2>&1
               systemctl enable "$service" >> /dev/null 2>&1
               systemctl start "$service" >> /dev/null 2>&1
               echo "$service đã được cài đặt và khởi động thành công!"
}


           configure_webfiles() {
               local choice=$1
               local duongdan
                  case $choice in
                     "1")
                        read -p "Hãy nhập đường dẫn của bạn: " duongdan
                        sudo cp "$duongdan" /var/www/html/
                        sudo chown -R www-data:www-data /var/www/html/
                        echo "Đang kiểm tra xem đã có file trong thư mục chứa..."
                        ls -l /var/www/html
                        ;;
                     "2")
                       create_default_files
                        ;;
                     *)
                       echo "Lựa chọn không hợp lệ"
                        ;;
                       esac
}


            create_default_files() {
                  echo "Đang tạo file index.html và style.css..."
                  create_html_file
                  create_css_file
                  echo "Đã tạo file index.html và style.css thành công!"
}

    main_menu() {
        while true; do
        echo -e "\nChọn hành động bạn muốn thực hiện:"
        echo "1) Kiểm tra dịch vụ"
        echo "2) Cài đặt dịch vụ"
        echo "3) Cấu hình dịch vụ"
        echo "4) Thoát"
        
        read -p "Nhập lựa chọn của bạn (1-4): " action
        
        case $action in
            1)
                service_check_menu
                ;;
            2)
                service_install_menu
                ;;
            3)
                service_config_menu
                ;;
            4)
                echo "Thoát khỏi chương trình."
                exit 0
                ;;
            *)
                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                ;;
        esac
    done
}

            service_check_menu() {
                 echo -e "\nChọn dịch vụ bạn muốn kiểm tra:"
                 echo "1) Apache"
                 echo "2) Nginx"
                 echo "3) Quay lại" 
                 read -p "Chọn dịch vụ (1-3): " choice
                 case $choice in
                     1) check_service "apache2" ;;
                     2) check_service "nginx" ;;
                     3) return ;;
                     *) echo "Lựa chọn không hợp lệ." ;;
                 esac
            }


            service_install_menu() {
                 echo -e "\nChọn dịch vụ bạn muốn cài đặt:"
                 echo "1) Apache"
                 echo "2) Nginx"
                 echo "3) Quay lại" 
                 read -p "Chọn dịch vụ (1-3): " choice
                 case $choice in
                     1) install_service "apache2" ;;
                     2) install_service "nginx" ;;
                     3) return ;;
                     *) echo "Lựa chọn không hợp lệ." ;;
                 esac
}

                 service_config_menu() {
                   echo -e "\nChọn dịch vụ bạn muốn cấu hình:"
                   echo "1) Apache"
                   echo "2) Nginx"
                   echo "3) Quay lại"
                   read -p "Chọn dịch vụ (1-3): " choice
                   case $choice in
                    1|2)
                         echo -e "\nChọn cách thức cấu hình:"
                         echo "1) Lấy file của tôi"
                         echo "2) Tạo file sẵn"
                         echo "3) Quay lại"
                         read -p "Chọn cách thức (1-3): " config_choice
                    if [ "$config_choice" != "3" ]; then
                        configure_webfiles "$config_choice"
                    fi
                    ;;
                    3) return ;;
                    *) echo "Lựa chọn không hợp lệ." ;;
                    esac
}

                create_html_file() {
                    sudo bash -c 'cat > /var/www/html/index.html << "EOF"
                    <!DOCTYPE html>
                    <html lang="vi">
                       <head>
                       <meta charset="UTF-8">
                       <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Trang Cá Nhân</title>
                                <link rel="stylesheet" href="style.css">
                       </head>
                       <body>
                                <header class="header">
                       <div class="container">
                                <h1 class="logo">Xin Chào! Tôi Là <span>Nguyen Kim Binh</span></h1>
                                <p class="tagline">Một người đam mê công nghệ và lập trình.</p>
                       </div>
                       </header>
                       <main class="content">
                         <section class="about">
                            <h2>Giới Thiệu</h2>
                               <p>Tôi không là ai cả, nhưng yêu thích học hỏi và khám phá những công nghệ mới.</p>
                            </section>
                            <section class="projects">
                            <h2>Dự Án</h2>
                               <ul>
                                 <li><a href="#">Dự án 1: Trang web cá nhân</a></li>
                                 <li><a href="#">Dự án 2: Ứng dụng quản lý công việc</a></li>
                                 <li><a href="#">Dự án 3: Blog chia sẻ kiến thức lập trình</a></li>
                               </ul>
                            </section>
                            </main>
                            <footer class="footer">
                            <p>Kết nối với tôi qua:
                               <a href="https://www.linkedin.com" target="_blank">LinkedIn</a> |
                               <a href="https://github.com" target="_blank">GitHub</a>
                            </p>
                               </footer>
                               </body>
                            </html>
                            EOF'
}


              create_css_file() {
                       sudo bash -c 'cat > /var/www/html/style.css << "EOF"
                              body, h1, h2, p, ul, li, a {
                              margin: 0; 
                              padding: 0;
                              text-decoration: none;
                              list-style: none;
                              }

                          body {
                             font-family: "Arial", sans-serif;
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

                        .footer a {
                        color: #4facfe;
                        margin: 0 5px;
                        transition: color 0.3s;
                        }

                        .footer a:hover {
                        color: #00f2fe;
                        }
                        EOF'
                        }

            check_root
            main_menu
            ;;
    2)
                check_php_installation() {
                    echo "Đang kiểm tra cài đặt PHP..."
                    if dpkg -l | grep -qw "php"; then
                        echo "PHP đã được cài đặt."
                        check_php_service
                    else
                        echo "PHP chưa được cài đặt. Tiến hành cài đặt..."
                        sudo apt update -y && sudo apt install -y php php-fpm
                        echo "PHP đã được cài đặt thành công."
                    fi
                }

            
                check_php_service() {
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
                }

 
                check_upgrade_php() {
                    echo "Đang kiểm tra phiên bản PHP..."
                    if ! command -v php > /dev/null; then
                        echo "PHP chưa được cài đặt."
                        return
                    fi
                    
                    echo "Phiên bản hiện tại: $(php -v | head -n 1)"
                    read -p "Bạn có muốn nâng cấp PHP không? (y/n): " upgrade_php
                    if [ "$upgrade_php" = "y" ]; then
                        sudo apt update -y && sudo apt upgrade -y php php-fpm
                        echo "PHP đã được nâng cấp thành công."
                    else
                        echo "Đã hủy nâng cấp PHP."
                    fi
                }


                check_xampp() {
                    echo "Đang kiểm tra XAMPP..."
                    if [ -d "/opt/lampp" ]; then
                        manage_htdocs
                    else
                        install_xampp
                    fi
                }

  
                manage_htdocs() {
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
                }

                install_xampp() {
                    echo "XAMPP chưa được cài đặt. Tiến hành tải về và cài đặt..."
                    wget -q https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.4/xampp-linux-x64-8.2.4-0-installer.run/download -O xampp-installer.run
                    chmod +x xampp-installer.run
                    sudo ./xampp-installer.run
                    echo "XAMPP đã được cài đặt thành công. Vui lòng kiểm tra lại các dịch vụ."
                }

     
                manage_database() {
                    echo "Bạn muốn sử dụng giao diện hay lệnh để kết nối?"
                    select db_option in "Giao diện" "Lệnh" "Quay lại"; do
                        case $db_option in
                            "Giao diện")
                                handle_gui_db
                                break
                                ;;
                            "Lệnh")
                                handle_cli_db
                                break
                                ;;
                            "Quay lại")
                                return
                                ;;
                            *)
                                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                ;;
                        esac
                    done
                }
  

                handle_gui_db() {
                    echo "Hãy truy cập: https://localhost/phpmyadmin để quản lý CSDL."
                    echo "Tại đây, bạn có thể tạo, chỉnh sửa, hoặc xóa bảng thông qua giao diện PHPMyAdmin."
                }

    
                handle_cli_db() {
                    read -p "Vui lòng nhập tên máy chủ (ví dụ: localhost): " server
                    read -p "Vui lòng nhập tên người dùng: " user
                    read -sp "Vui lòng nhập mật khẩu: " password
                    echo
                    read -p "Vui lòng nhập tên cơ sở dữ liệu: " database

                    if mysql -h "$server" -u "$user" -p"$password" -e "USE $database;" 2>/dev/null; then
                        handle_db_operations "$server" "$user" "$password" "$database"
                    else
                        echo "Kết nối không thành công. Vui lòng kiểm tra lại thông tin."
                    fi
                }

    
                handle_db_operations() {
                    local server=$1
                    local user=$2
                    local password=$3
                    local database=$4

                    echo "Kết nối tới cơ sở dữ liệu thành công."
                    while true; do
                        echo "Bạn muốn thực hiện tác vụ nào?"
                        select db_task in "Tạo bảng" "Chỉnh sửa bảng" "Xóa bảng" "Quay lại"; do
                            case $db_task in
                                "Tạo bảng")
                                    create_table "$server" "$user" "$password" "$database"
                                    break
                                    ;;
                                "Chỉnh sửa bảng")
                                    alter_table "$server" "$user" "$password" "$database"
                                    break
                                    ;;
                                "Xóa bảng")
                                    drop_table "$server" "$user" "$password" "$database"
                                    break
                                    ;;
                                "Quay lại")
                                    return
                                    ;;
                                *)
                                    echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                    ;;
                            esac
                        done
                    done
                }

                #
                create_table() {
                    local server=$1
                    local user=$2
                    local password=$3
                    local database=$4

                    read -p "Nhập tên bảng muốn tạo: " table_name
                    echo "Nhập cấu trúc các cột cho bảng (ví dụ: id INT PRIMARY KEY, name VARCHAR(100), age INT):"
                    read -p "Cấu trúc cột: " columns
                    
                    if mysql -h "$server" -u "$user" -p"$password" -e "CREATE TABLE $database.$table_name ($columns);" 2>/dev/null; then
                        echo "Bảng '$table_name' đã được tạo thành công."
                    else
                        echo "Không thể tạo bảng. Vui lòng kiểm tra cú pháp và thông tin."
                    fi
                }

   
                alter_table() {
                    local server=$1
                    local user=$2
                    local password=$3
                    local database=$4

                    read -p "Nhập tên bảng muốn chỉnh sửa: " table_name
                    echo "Nhập câu lệnh SQL chỉnh sửa bảng (ví dụ: ALTER TABLE table_name ADD COLUMN email VARCHAR(100)):"
                    read -p "Câu lệnh SQL: " alter_query
                    
                    if mysql -h "$server" -u "$user" -p"$password" -e "$alter_query;" 2>/dev/null; then
                        echo "Bảng '$table_name' đã được chỉnh sửa thành công."
                    else
                        echo "Không thể chỉnh sửa bảng. Vui lòng kiểm tra câu lệnh SQL."
                    fi
                }

   
                drop_table() {
                    local server=$1
                    local user=$2
                    local password=$3
                    local database=$4

                    read -p "Nhập tên bảng muốn xóa: " table_name
                    read -p "Bạn có chắc chắn muốn xóa bảng '$table_name'? Hành động này không thể hoàn tác! (y/n): " confirm
                    
                    if [ "$confirm" = "y" ]; then
                        if mysql -h "$server" -u "$user" -p"$password" -e "DROP TABLE $database.$table_name;" 2>/dev/null; then
                            echo "Bảng '$table_name' đã được xóa thành công."
                        else
                            echo "Không thể xóa bảng. Vui lòng kiểm tra thông tin."
                        fi
                    else
                        echo "Hủy xóa bảng."
                    fi
                }

    
                check_apache_status() {
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
                }

    
                config_php() {
                    while true; do
                        echo -e "\nVui lòng chọn tác vụ cần thực hiện:"
                        echo "1) Cài đặt PHP"
                        echo "2) Kiểm tra và nâng cấp PHP"
                        echo "3) Kiểm tra XAMPP"
                        echo "4) Kết nối và quản lý CSDL (XAMPP)"
                        echo "5) Kiểm tra trạng thái dịch vụ Apache"
                        echo "6) Thoát"
                        
                        read -p "Nhập số để chọn tác vụ: " action
                        
                        case $action in
                            1) check_php_installation ;;
                            2) check_upgrade_php ;;
                            3) check_xampp ;;
                            4) manage_database ;;
                            5) check_apache_status ;;
                            6) 
                                echo "Đã thoát khỏi chương trình."
                                exit 0
                                ;;
                            *)
                                echo "Lựa chọn không hợp lệ. Vui lòng chọn lại."
                                ;;
                        esac
                    done
                }

    
                echo "Bạn đã chọn Cài đặt và sử dụng PHP"
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

                                        # Kiểm tra xem user có tồn tại không
                                        if id "$username" &>/dev/null; then
                                            # Thêm user vào group sudo
                                            sudo usermod -aG sudo "$username"
                                            if [ $? -eq 0 ]; then
                                                echo "User đã được nâng cấp lên Super User thành công."
                                                
                                                # Mở file sudoers bằng visudo để chỉnh sửa
                                                echo "Thêm cấu hình trong /etc/sudoers..."
                                                sudo bash -c "echo '$username ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
                                                
                                                if [ $? -eq 0 ]; then
                                                    echo "Đã thêm user vào sudoers thành công."
                                                else
                                                    echo "Có lỗi khi thêm user vào sudoers."
                                                fi
                                            else
                                                echo "Có lỗi khi nâng cấp user."
                                            fi
                                        else
                                            echo "User không tồn tại. Vui lòng kiểm tra lại."
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
                        echo "Đang cấu hình tên miền cho hệ thống của bạn..."
                            host_name=$(hostname | awk -F"." '{print $1}')
                        echo "Nhập tên miền mới cho hệ thống của bạn: "
                            read -r domain_name
                            if [[ -z "$domain_name" ]]; then
                        echo "Lỗi: Tên miền không được để trống."
                            exit 1
                            fi

                        fqdn="${host_name}.${domain_name}"
                        echo "Mở tệp /etc/hostname để chỉnh sửa thủ công..."
                            sudo nano /etc/hostname
                            echo "$fqdn" | sudo tee /etc/hostname >/dev/null
                            fqdomain_name=$(cat /etc/hostname)
                            echo "Tên miền đầy đủ (FQDN) đã được cập nhật thành: $fqdomain_name"
                            echo "Thay đổi đã được lưu trong /etc/hostname." 

                        echo "Tên miền đầy đủ (FQDN) đã được cập nhật thành: $fqdn"
                        echo "Tên máy lưu trong /etc/hostname: $(cat /etc/hostname)"
                        echo "Tên máy hiện tại của hệ thống: $fqdomain_name"
                        echo "Nội dung tệp /etc/hosts:"
                        cat /etc/hosts

                        echo "Gán các tệp cấu hình vào các biến..."
                            named_file="/etc/bind/named.conf"
                            forward_file="/var/cache/bind/forward.$domain_name"
                            reverse_file="/var/cache/bind/reverse.$domain_name"

                        echo "Liệt kê các giao diện mạng khả dụng..."
                            net_int=$(ip -o link show | awk -F': ' '{print $2}')
                            echo $net_int
                            echo "Nhập tên giao diện mạng để cấu hình máy chủ DNS: "
                            read -r net_int_name

                        echo "Gán các địa chỉ IP vào các biến..."
                            net_int_ip=$(ifconfig $net_int_name | awk -F' ' 'FNR == 2 {print $2}')
                            echo "${net_int_ip} ${fqdomain_name}" >> /etc/hosts
                            oct_1=$(echo $net_int_ip | cut -d"." -f1)
                            oct_2=$(echo $net_int_ip | cut -d"." -f2)
                            oct_3=$(echo $net_int_ip | cut -d"." -f3)
                            oct_4=$(echo $net_int_ip | cut -d"." -f4)
                            first_3_oct_reverse="${oct_3}.${oct_2}.${oct_1}"
                            desktop_ip="${oct_1}.${oct_2}.${oct_3}.$(expr $oct_4 - 1)"

                        echo "Cài đặt các gói cho máy chủ DNS..."
                            apt install -y bind9 bind9utils bind9-doc >/dev/null 2>&1

                        echo "Cấu hình tệp cấu hình máy chủ “named” với địa chỉ IP tại dòng 13."
                            sed -i "13s/^\(.\{32\}\)/\1$net_int_ip; /" $named_file

                        echo "Kích hoạt quy tắc tường lửa cho phép lưu lượng DNS."
                            ufw allow 53/tcp
                            ufw allow 53/udp

                        echo "Bật, khởi động và kiểm tra trạng thái của máy chủ “named”."
                            systemctl enable bind9 >/dev/null 2>&1
                            systemctl start bind9 >/dev/null 2>&1
                            systemctl status bind9 --no-pager >/dev/null 2>&1

                        echo "Cấu hình vùng chính cho máy chủ DNS..."
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

                        echo "Cấu hình vùng tra cứu ngược cho máy chủ DNS."
                            sed -i '65s/^/.in-addr.arpa" IN {/' $named_file
                            sed -i "65s/^/$first_3_oct_reverse/ $named_file"
                            sed -i '65s/^/zone "/' $named_file
                            sed -i '66s/^/\t type master;/' $named_file
                            sed -i '67s/^/ \t file "reverse./' $named_file
                            sed -i "67s/^/$domain_name/ $named_file"
                            sed -i '67s/^/ \t file "reverse./' $named_file
                            sed -i '68s/^/ \t allow-update { none; };/ $named_file'
                            sed -i '69s/^/};/' $named_file

                        echo "Cấu hình tệp vùng tiến của máy chủ DNS..."
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

                        echo "Cấu hình tệp vùng ngược."
                            cp $forward_file $reverse_file
                            sed -i -e "10s/A/PTR/;10s/${net_int_ip}/${domain_name}./" $reverse_file
                        echo "11 IN PTR server.$domain_name.
                            10 IN PTR desktop.$domain_name." >> $reverse_file

                        echo "Cấu hình quyền sở hữu các tệp vùng tiến và ngược."
                            chown root:bind $forward_file
                            chown root:bind $reverse_file

                        echo "Kiểm tra tính hợp lệ của các tệp cấu hình máy chủ DNS."
                            named-checkconf -z $named_file
                            named-checkzone forward $forward_file
                            named-checkzone reverse $reverse_file 
                        echo "Khởi động lại máy chủ DNS."
                            systemctl restart bind9 >/dev/null 2>&1
                            ;;
                            esac
                        }
    config_dns
    ;;
    4)
            echo "Bạn đã chọn Cài đặt và sử dụng Mailserver."

            config_Mailserver() {
                echo "Chọn chức năng:"
                echo "1) Cài đặt Postfix Server"
                echo "2) Cấu hình cơ bản cho Postfix"
                echo "3) Tạo tài khoản email"
                echo "4) Kích hoạt TLS để bảo mật"
                read -p "Nhập lựa chọn: " choice

                case $choice in
                1)
                    echo "Cài đặt và cấu hình Postfix Server..."
                    sudo apt update && sudo apt upgrade -y
                    sudo apt install -y postfix
                    DOMAIN=$(cat /etc/hostname)
                    sudo debconf-set-selections <<< "postfix postfix/mailname string $DOMAIN"
                    sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
                    sudo systemctl restart postfix
                    sudo systemctl enable postfix
                    echo "Postfix đã được cài đặt thành công!"
                    ;;
                2)
                    echo "Cấu hình cơ bản cho Postfix..."
                    sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.bak
                    sudo bash -c "cat >> /etc/postfix/main.cf <<EOF
                            myhostname = mail.$DOMAIN
                            mydomain = $DOMAIN
                            myorigin = \$mydomain

                            inet_interfaces = all
                            inet_protocols = ipv4

                            mydestination = \$myhostname, localhost.\$mydomain, localhost, \$mydomain
                            mynetworks = 127.0.0.0/8, [::1]/128

                            # Kích thước email tối đa (10MB)
                            message_size_limit = 10485760
                            EOF"
                    sudo systemctl restart postfix
                    echo "Cấu hình Postfix đã được cập nhật!"
                    ;;
                3)
                    echo "Tạo tài khoản email..."
                    read -p "Nhập địa chỉ email (VD: user@example.com): " EMAIL
                    read -sp "Nhập mật khẩu cho tài khoản: " PASSWORD
                    echo ""

                    MAIL_DIR="/var/mail/vmail"
                    sudo mkdir -p $MAIL_DIR
                    sudo groupadd -g 5000 vmail || true
                    sudo useradd -g vmail -u 5000 vmail -d $MAIL_DIR -s /sbin/nologin || true

                    VIRTUAL_USERS="/etc/postfix/virtual_users"
                    sudo bash -c "echo '$EMAIL    $MAIL_DIR/$EMAIL/' >> $VIRTUAL_USERS"
                    sudo postmap $VIRTUAL_USERS

                    sudo bash -c "cat >> /etc/postfix/main.cf <<EOF
                            virtual_mailbox_domains = $DOMAIN
                            virtual_mailbox_base = $MAIL_DIR
                            virtual_mailbox_maps = hash:/etc/postfix/virtual_users
                            virtual_uid_maps = static:5000
                            virtual_gid_maps = static:5000
                            EOF"
                    sudo systemctl restart postfix
                    echo "Tài khoản email $EMAIL đã được tạo thành công!"
                    ;;
                4)
                    echo "Kích hoạt TLS để bảo mật..."
                    SSL_DIR="/etc/ssl/postfix"
                    sudo mkdir -p $SSL_DIR
                    sudo openssl req -new -x509 -days 365 -nodes -out $SSL_DIR/postfix_cert.pem -keyout $SSL_DIR/postfix_key.pem \
                        -subj "/C=US/ST=State/L=City/O=Example/OU=IT/CN=mail.$DOMAIN"

                    sudo chmod 600 $SSL_DIR/postfix_key.pem
                    sudo chown root:root $SSL_DIR/postfix_key.pem

                    sudo bash -c "cat >> /etc/postfix/main.cf <<EOF
                        # Cấu hình TLS
                        smtpd_tls_cert_file = $SSL_DIR/postfix_cert.pem
                        smtpd_tls_key_file = $SSL_DIR/postfix_key.pem
                        smtpd_use_tls = yes
                        smtpd_tls_security_level = encrypt
                        smtp_tls_security_level = may
                        smtpd_tls_auth_only = yes
                        EOF"
                    sudo systemctl restart postfix
                    echo "TLS đã được kích hoạt thành công!"
                    ;;
                *)
                    echo "Lựa chọn không hợp lệ!"
                    ;;
                esac
            }

    config_Mailserver
    ;;
        6)
        config_noidungfielsystem() {
                        echo " Kiến thức System administration Linux"
                echo " ----------------------------------------------------"
                echo " 1) Hệ thống tệp Pseudo ? "
                echo " 2) Kernel "
                echo " 3) Quá trình khởi động nền (Init background) "
                echo " 4) Mức chạy (Run level) "
                echo " 5) Hệ thống tệp "
                echo " 6) MBR và GPT "
                echo " 7) Chia sẻ đối tượng (Share object) "
                echo " 8) APT và công cụ quản lý gói Debian (.deb) "
                echo " 9) Công cụ quản lý gói: yum "
                echo " 10) Shell Linux "
                echo " 11) Làm việc với các tệp "
                echo " 12) Tiến trình "
                echo " 13) Hệ thống tệp Linux "
                echo " 14) Quản lý sử dụng "
                echo " 15) Cấu hình thiết lập quyền, mặc định của tệp và thư mục "
                echo " 16) Liên kết cứng và liên kết mềm "
                echo " 17) Tiêu chuẩn phân cấp hệ thống (FHS) "
                echo " 18) Tìm kiếm trong Linux "
                echo " 19) Các tệp cấu hình của user và group "
                echo " 20) Timer Units "
                echo " 21) Các tệp nhật ký tiêu chuẩn của Linux (Standard Linux log files) "
                echo " 22) Dịch vụ gửi và nhận mail trong Linux (Message Transfer Agent) "
                echo " 23) Mạng "
                echo " 24) Xác định trạng thái bảo mật hiện tại của hệ thống Linux "
                echo " 25) Bảo mật các đăng nhập local "
                echo " 26) Mục đích khởi động shell Linux là gì? "
                echo " 27) Các tệp chính, thư mục chính và lệnh của Apache "
                echo " 28) DHCP server "
                echo " 29) DNS server "
                echo " 30) Samba server "
                echo " -------------------------------------------------------"
                read -p "Chọn chức năng: " choice

            case $choice in
                        1) echo " Hệ thống tệp Pseudo  " 
                        echo " File system thông thường là một phương pháp sắp xếp các files và thư mục trên ổ đĩa (cứng) vật lý. 
                Nó là tập hợp logic các files và thư mục nằm trên một phân vùng (partition). 
                Một pseudo file system (giả hoặc ảo) không tồn tại trên ổ cứng vật lý mà chỉ tồn tại trên RAM, do hệ điều hành tạo ra trong quá trình hoạt động. 

                Có nhiều loại file system, nhưng có hai thư mục chính trong pseudo file system:
                - /proc: Chứa thông tin về các tiến trình (process) đang chạy trong hệ điều hành Linux, được liệt kê theo PID, cũng như dữ liệu phần cứng và tiến trình.
                - /sys: Chứa thông tin về phần cứng của máy tính và kernel, không liên quan đến các tiến trình được liệt kê.

                Một số lệnh thường dùng để làm việc với file system:
                - man: Đọc tài liệu hướng dẫn cho các lệnh hoặc chức năng.
                - cd (change directory): Di chuyển đến thư mục mong muốn.
                - ls: Liệt kê danh sách file và thư mục trong thư mục hiện tại.
                - PID: ID của một tiến trình.
                - cat: Hiển thị nội dung của một file.
                - systemd: Quản lý tiến trình và các dịch vụ của hệ điều hành.
                - XFS: Một hệ thống file hiện đại, tối ưu để lưu trữ dữ liệu trong các máy tính hiện đại, thường được dùng cho dữ liệu lớn.

                Những kiến thức này giúp bạn hiểu rõ hơn về cách hệ điều hành Linux tổ chức và quản lý file system."
            ;;
                   2)  echo " Kernel " 
                   echo "2) Kernel  
                        Kernel (hạt nhân) là khung cốt lõi của hệ điều hành Linux. Nó đóng vai trò như một cầu nối giữa phần cứng và phần mềm, quản lý tài nguyên hệ thống và đảm bảo mọi thành phần hoạt động trơn tru.

                        ### **Cách thức hoạt động của Linux Kernel**
                        Linux Kernel dựa trên kiến trúc nguyên khối (*monolithic*), nghĩa là toàn bộ hệ điều hành, bao gồm các chức năng cốt lõi, đều nằm trong không gian kernel. Điều này khác với kiến trúc *microkernel* (chỉ chứa các chức năng cơ bản nhất trong kernel).

                        **Sơ đồ hoạt động:**

                        1. **User Mode**:  
                        - **Applications (Người dùng)**  
                        - **Standard Libraries** (chứa shell, lệnh, compiler, và interpreters)  
                            |
                        - **System Call Interface** (giao diện gọi hệ thống đến kernel)  
                            |
                            v  

                        2. **Kernel Mode (Kernel)**:  
                        - Xử lý thiết bị đầu cuối, tín hiệu đến trình điều khiển hệ thống.  
                        - Quản lý hệ thống tập tin, hoán đổi dữ liệu I/O, hệ thống đĩa và trình điều khiển băng.  
                        - Lập lịch CPU, thay thế trang, phân trang bộ nhớ ảo.  
                            |
                        - **Giao diện Kernel với phần cứng**  
                            |
                            v  

                        3. **Phần cứng**:  
                        - Thiết bị đầu cuối, điều khiển thiết bị đĩa và băng, bộ nhớ vật lý, bộ điều khiển.

                        ---

                        ### **Thông tin Kernel trong hệ thống Linux**
                        - Kernel nằm trong thư mục **/boot** trên các hệ thống Debian/Ubuntu.  
                        - Trên các hệ thống khác, nó có thể nằm ở một phân vùng khởi động riêng biệt.  

                        ---

                        ### **Chức năng của Kernel**

                        1. **Quản lý bộ nhớ:**  
                        - **Bảng page**: Lưu trữ ánh xạ giữa địa chỉ ảo và địa chỉ vật lý.  
                        - **Phân bổ (paging)**: Chia bộ nhớ thành các trang (*page*) có kích thước cố định (thường là 4096 byte) để dễ quản lý.  
                        - **Phân mảnh bộ nhớ**: Xảy ra khi bộ nhớ bị chia thành nhiều phần không liền kề, ảnh hưởng đến hiệu suất hệ thống.  
                        - **Bộ nhớ ảo**: Cho phép các tiến trình sử dụng nhiều bộ nhớ hơn bộ nhớ vật lý thực tế, tạo không gian địa chỉ riêng biệt và bảo vệ hệ thống khỏi truy cập trái phép.  

                        2. **Quản lý tiến trình:**  
                        - Lập lịch và quản lý các tiến trình đang chạy.  

                        ---

                        ### **Các lệnh sử dụng với Kernel**

                        - uname : Hiển thị thông tin về kernel đang chạy.  
                        - lsmod : Hiển thị danh sách các module kernel đã tải.  
                        - modinfo : Hiển thị thông tin chi tiết về một module kernel.  
                        - modprobe : Tải hoặc gỡ bỏ một module kernel đang chạy.
"                                    
                   ;;
                   3) echo "File System"
                        echo "Init là viết tắt của initialization (tiến trình khởi động), dựa trên SystemV Init (Unix). 
                            Các dịch vụ được bắt đầu theo thứ tự tuần tự (kiểu nối tiếp). 
                            
                            Quá trình khởi động: 
                            Kernel -> /sbin/init -> /etc/inittab
                            
                            Run Levels:
                            0) Tắt máy (Hệ điều hành ngừng hoạt động).
                            1) Single User Mode (Chế độ một người dùng, không có mạng, không chạy tiến trình, chỉ cho phép đăng nhập user root).
                            2) Chế độ không có mạng, nhưng các tiến trình cơ bản được khởi động.
                            3) Chế độ khởi động bình thường (Giao diện dòng lệnh - Command Line).
                            4) Không sử dụng (Chưa được cấu hình).
                            5) Chế độ đồ họa (Multi-user + Mạng + Giao diện đồ họa).
                            6) Khởi động lại (Reboot).
                            
                            File /etc/inittab:
                            - Chứa thông tin cấu hình, bao gồm nhiều trường như sau:
                                Identifier + Level + Action + Process (các trường được phân cách bằng dấu :)  
                            
                            Các Action phổ biến:
                            - wait: Chạy tiến trình khi Run Level được kích hoạt. Init sẽ chờ cho đến khi tiến trình này kết thúc.
                        "
                     ;;  
                     4) echo "Mục chạy (Run Level)"
                        echo "
                        Các lệnh thông dụng liên quan đến Run Level:

                        1. **runlevel**: Xem Run Level hiện tại của hệ điều hành.
                        2. **telinit**: Chuyển từ Run Level hiện tại sang một Run Level khác.

                        ### **Thay đổi Run Level của Linux khi khởi động:**
                        - Trong quá trình khởi động, nhấn phím bất kỳ trên bàn phím để dừng tại GRUB.
                        - Chọn kernel để sửa đổi (nhấn phím 'a').
                        - Thêm đối số vào cuối dòng kernel để thiết lập Run Level mong muốn.

                        ---

                        ### **Systemd và Target**
                        - **Systemd**: Là tiến trình đầu tiên được khởi chạy trong hệ điều hành Linux.
                        - **Target**: Là một đơn vị (*unit*) đồng bộ hóa các đơn vị khác khi máy tính khởi động hoặc thay đổi trạng thái. Target thường được dùng để chuyển hệ điều hành sang trạng thái khác.

                        **Ví dụ về các Target:**
                        - Chuyển Linux vào giao diện dòng lệnh: multi-user.target
                        - Chuyển sang giao diện đồ họa: graphical.target

                        **Các Target phổ biến và chức năng:**
                        1. **multi-user.target**: Tương tự Run Level 3 trong System V. Cho phép nhiều người dùng đăng nhập vào hệ thống.
                        2. **graphical.target**: Tương tự Run Level 5 trong System V. Chuyển hệ điều hành sang chế độ đồ họa.
                        3. **rescue.target**: Tương tự Run Level 1, chuyển hệ điều hành vào chế độ cơ bản với file system được mount. Cung cấp một Rescue Shell để sửa lỗi.
                        4. **basic.target**: Chuyển hệ điều hành vào chế độ cơ bản, thường được sử dụng trong quá trình khởi động trước khi chuyển sang Target mặc định.
                        5. **sysinit.target**: Khởi tạo hệ thống (System Initialization).
                        6. **man 5 systemd.target**: Xem cấu hình của Target Unit.
                        7. **man 7 systemd.special**: Xem tài liệu về tất cả các Target Units và định nghĩa của chúng.
                        8. **systemctl list-unit-files --type=target**: Hiển thị các Unit Files của các Target có trong hệ điều hành.
                        9. **systemctl list-units --type=target**: Hiển thị các Unit Files đã được nạp và kích hoạt trong hệ điều hành.
                        10. **systemctl get-default**: Hiển thị Target mặc định của hệ điều hành.
                        11. **systemctl set-default [target]**: Chuyển Target mặc định sang một Target khác.
                        12. **systemctl isolate [target]**: Chuyển đổi trạng thái hệ điều hành sang một trạng thái khác.

                        ---

                        ### **Các lệnh Systemd tương ứng với System V:**
                        - **systemctl reboot**: Tương ứng Run Level 6 (khởi động lại hệ thống).
                        - **systemctl poweroff**: Tương ứng Run Level 0 (tắt hệ thống).
                        - **systemctl halt**: Tương ứng Run Level 1 (ngưng hệ thống).
                        - **systemctl suspend**: Đưa hệ thống vào chế độ treo.
                        - **systemctl hibernate**: Đưa hệ thống vào chế độ ngủ đông.
                        - **systemctl reboot**: Khởi động lại hệ thống (tương tự Run Level 6).

                        "
                        ;;
                     5) echo " filesystem "  
                        echo " 
                        1) Thu muc goc ( / ) derectory " root " chu tat ca cac thu muc 
                        2) /Var la thu muc thuong la chua cac loai thu muc va cac noi dung dong ( web sites)
                        3) /home la chua cac thu muc cua user home luu cac file thu muc co nhan cua nguoi dung vi du nhu /home/binh
                        4) /opt la thu muc cho cac phan mem ung dung ( optional software ) cua cac nha cung cap phan mem thu 3 . moi truong doanh nghiep thuong su dung thu muc nay 
                        5) /swap la bo luu tru tam thoi giong nhu ram ( ram ao ) -> khi 1 ty le phan% bi day , linux kernel se chuyen du lieu it su dung hon sang swap co 2 loai swap
                             + swap (partition) : pho bien nhat trong cai dat cau hinh Swap 
                             + swap file : tuong tu giong page files trong he dieu hanh Windows ) - > co hieu suat su dung kuu vao ra du lieu cham hon swap 
                             Sizing 
                        "
                     ;;
                     6) 
                        echo "============================================"
                        echo "            So sánh MBR và GPT              "
                        echo "============================================"

                        echo ""
                        echo "1. MBR (Master Boot Record):"
                        echo "   - Ra đời: 1983."
                        echo "   - Cấu trúc:"
                        echo "     + Dữ liệu khởi động nằm ở sector đầu tiên (512 bytes đầu tiên)."
                        echo "     + Chứa tối đa 4 phân vùng chính (Primary Partitions)."
                        echo "   - Hạn chế:"
                        echo "     + Hỗ trợ tối đa 2TB dung lượng ổ đĩa."
                        echo "     + Tối đa 4 phân vùng chính, cần phân vùng mở rộng để thêm."
                        echo "   - Hỗ trợ: Thích hợp với hệ thống BIOS cũ."
                        echo ""

                        echo "2. GPT (GUID Partition Table):"
                        echo "   - Ra đời: Cuối thập niên 1990, phát triển cùng UEFI."
                        echo "   - Cấu trúc:"
                        echo "     + Lưu trữ bảng phân vùng tại nhiều vị trí (Primary & Backup Header)."
                        echo "     + Mỗi phân vùng có GUID (Globally Unique Identifier)."
                        echo "   - Ưu điểm:"
                        echo "     + Hỗ trợ ổ đĩa lên đến 18EB."
                        echo "     + Không giới hạn số lượng phân vùng (thường 128 trên Windows)."
                        echo "     + An toàn hơn nhờ khả năng sao lưu bảng phân vùng."
                        echo "   - Hỗ trợ: Yêu cầu hệ thống UEFI và các hệ điều hành hiện đại."
                        echo ""

                        echo "============================================"
                        echo "           So sánh chính giữa MBR và GPT    "
                        echo "============================================"
                        echo "| Tiêu chí            | MBR                 | GPT                  |"
                        echo "|---------------------|---------------------|----------------------|"
                        echo "| Dung lượng tối đa   | 2TB                 | >18EB                |"
                        echo "| Số phân vùng        | Tối đa 4 chính      | Không giới hạn       |"
                        echo "| Cơ chế khởi động    | BIOS                | UEFI                 |"
                        echo "| Khả năng khôi phục  | Không an toàn       | An toàn hơn          |"
                        echo "| Tương thích         | Hệ thống cũ (BIOS) | Hệ thống mới (UEFI)  |"
                        echo "============================================"
                        echo ""

                        echo "Khi nào chọn MBR hay GPT?"
                        echo "1. Chọn MBR nếu:"
                        echo "   - Hệ thống dùng BIOS cũ."
                        echo "   - Ổ đĩa nhỏ hơn 2TB."
                        echo "   - Cần tương thích với hệ thống cũ."
                        echo ""
                        echo "2. Chọn GPT nếu:"
                        echo "   - Ổ đĩa lớn hơn 2TB."
                        echo "   - Muốn tận dụng lợi thế của UEFI."
                        echo "   - Yêu cầu bảo mật và khôi phục tốt hơn."
                        echo ""

                        echo "============================================"
                        echo "     Kết luận: GPT là lựa chọn tốt hơn      "
                        echo "============================================"
                    ;;
                    7)

                        echo "============================================"
                        echo "         Chia sẻ đối tượng (Share object)   "
                        echo "============================================"

                        echo ""
                        echo "1. Định nghĩa:"
                        echo "   - Chia sẻ đối tượng (Share Object) là kỹ thuật trong lập trình, đặc biệt"
                        echo "     phổ biến trong hệ thống Linux/Unix, để sử dụng các thư viện hoặc đối tượng"
                        echo "     được tải động (shared libraries)."
                        echo "   - Các thư viện này thường có phần mở rộng '.so' (Shared Object)."
                        echo ""

                        echo "2. Lợi ích của Chia sẻ đối tượng:"
                        echo "   - **Tiết kiệm bộ nhớ:**"
                        echo "     + Các thư viện được nạp một lần và chia sẻ giữa các tiến trình sử dụng."
                        echo "   - **Tính linh hoạt:**"
                        echo "     + Thay thế hoặc cập nhật thư viện dễ dàng mà không cần biên dịch lại chương trình."
                        echo "   - **Giảm kích thước ứng dụng:**"
                        echo "     + Chương trình không cần liên kết tĩnh tất cả mã nguồn, giảm kích thước file thực thi."
                        echo ""

                        echo "3. Cách hoạt động:"
                        echo "   - Khi một chương trình yêu cầu một thư viện chia sẻ:"
                        echo "     + Hệ điều hành nạp thư viện (nếu chưa nạp)."
                        echo "     + Các tiến trình khác cũng có thể sử dụng thư viện đã được nạp."
                        echo "   - Cơ chế này được quản lý bởi **linker** và **loader** trên hệ thống."
                        echo ""

                        echo "4. Ứng dụng phổ biến:"
                        echo "   - Các chương trình lớn như trình duyệt, máy chủ, hay phần mềm đồ họa."
                        echo "   - Các ngôn ngữ lập trình như C/C++ sử dụng '.so' để giảm tải và tăng hiệu suất."
                        echo ""

                        echo "5. Hạn chế:"
                        echo "   - Phụ thuộc vào phiên bản thư viện:"
                        echo "     + Nếu thư viện được cập nhật không tương thích, chương trình có thể bị lỗi."
                        echo "   - Tăng độ phức tạp trong quản lý thư viện và gỡ lỗi."
                        echo ""

                        echo "============================================"
                        echo "      Tổng kết: Chia sẻ đối tượng là gì?    "
                        echo "============================================"
                        echo "   Chia sẻ đối tượng là một phương pháp tối ưu hóa việc sử dụng bộ nhớ"
                        echo "   và tăng tính linh hoạt trong phát triển phần mềm. Tuy nhiên, việc"
                        echo "   quản lý các thư viện này cần được thực hiện cẩn thận để tránh lỗi."
                        echo "============================================"
                     ;;
                     8) 
                        echo "============================================"
                        echo "        APT và công cụ quản lý gói Debian   "
                        echo "============================================"

                        echo ""
                        echo "1. APT (Advanced Package Tool):"
                        echo "   - APT là một công cụ mạnh mẽ được sử dụng để quản lý gói phần mềm trên hệ thống Debian và các phân phối Linux dựa trên Debian như Ubuntu."
                        echo "   - Nó cung cấp giao diện dòng lệnh và các công cụ đồ họa để cài đặt, nâng cấp, gỡ bỏ các gói phần mềm."
                        echo "   - APT giúp quản lý các kho lưu trữ phần mềm, tự động tải về các phụ thuộc cần thiết khi cài đặt một gói."
                        echo ""

                        echo "2. Các công cụ chính của APT:"
                        echo "   - **apt-get**: Công cụ dòng lệnh để cài đặt, cập nhật, và gỡ bỏ các gói phần mềm."
                        echo "   - **apt-cache**: Công cụ để tìm kiếm các gói trong kho phần mềm."
                        echo "   - **aptitude**: Một giao diện dòng lệnh cao cấp hơn so với apt-get, cung cấp các chức năng tương tự."
                        echo "   - **apt**: Cung cấp giao diện đơn giản cho người dùng thay thế cho apt-get và apt-cache."
                        echo ""

                        echo "3. Các lệnh cơ bản của APT:"
                        echo "   - **apt-get update**: Cập nhật danh sách gói phần mềm từ các kho lưu trữ."
                        echo "   - **apt-get upgrade**: Nâng cấp các gói đã cài đặt lên phiên bản mới nhất."
                        echo "   - **apt-get install <package>**: Cài đặt một gói phần mềm."
                        echo "   - **apt-get remove <package>**: Gỡ bỏ một gói phần mềm."
                        echo "   - **apt-get autoremove**: Gỡ bỏ các gói không còn cần thiết."
                        echo ""

                        echo "4. Gói phần mềm Debian (.deb):"
                        echo "   - Gói phần mềm Debian (.deb) là định dạng tệp được sử dụng để đóng gói và phân phối phần mềm trên các hệ thống Debian và Ubuntu."
                        echo "   - Các gói .deb chứa các tệp nhị phân và các script cần thiết để cài đặt phần mềm vào hệ thống."
                        echo "   - Bạn có thể cài đặt một gói .deb bằng lệnh: **dpkg -i <package>.deb**."
                        echo ""

                        echo "5. Lợi ích của việc sử dụng APT và gói .deb:"
                        echo "   - **Quản lý phụ thuộc tự động**: APT tự động cài đặt các phụ thuộc cần thiết khi cài đặt phần mềm."
                        echo "   - **Cập nhật dễ dàng**: APT giúp cập nhật hệ thống và các gói phần mềm lên phiên bản mới nhất một cách nhanh chóng."
                        echo "   - **Dễ dàng cài đặt phần mềm từ kho phần mềm**: Kho phần mềm Debian có sẵn hàng nghìn gói phần mềm có sẵn để cài đặt."
                        echo ""

                        echo "6. Cách quản lý gói với APT:"
                        echo "   - **Thêm kho lưu trữ mới**: Bạn có thể thêm kho phần mềm mới vào hệ thống thông qua tập tin /etc/apt/sources.list."
                        echo "   - **Kiểm tra trạng thái gói**: Dùng lệnh **apt-cache show <package>** để xem thông tin chi tiết về một gói phần mềm."
                        echo ""

                        echo "============================================"
                        echo "              Tổng kết APT và .deb          "
                        echo "============================================"
                        echo "   APT là một công cụ mạnh mẽ giúp quản lý các gói phần mềm trên hệ thống Debian và Ubuntu,"
                        echo "   trong khi các gói .deb là định dạng tiêu chuẩn để phân phối phần mềm trong các hệ thống này."
                        echo "============================================"
                     
                     ;;
                     9)
                        echo "============================================"
                        echo "        Công cụ quản lý gói: yum            "
                        echo "============================================"

                        echo ""
                        echo "1. Định nghĩa về yum:"
                        echo "   - Yum (Yellowdog Updater, Modified) là một công cụ quản lý gói phần mềm phổ biến trên các hệ thống Linux sử dụng RPM (Red Hat Package Manager),"
                        echo "     như Red Hat, CentOS, Fedora, và các hệ phân phối Linux khác."
                        echo "   - Yum giúp người dùng dễ dàng cài đặt, cập nhật, gỡ bỏ, và quản lý các gói phần mềm trên hệ thống của họ."
                        echo ""

                        echo "2. Các tính năng chính của yum:"
                        echo "   - **Cài đặt và cập nhật gói phần mềm:**"
                        echo "     + Yum tự động giải quyết phụ thuộc khi cài đặt hoặc cập nhật các gói phần mềm."
                        echo "   - **Quản lý kho phần mềm (Repositories):**"
                        echo "     + Yum có thể truy cập và quản lý nhiều kho phần mềm từ các máy chủ từ xa."
                        echo "   - **Gỡ bỏ và nâng cấp phần mềm:**"
                        echo "     + Cho phép gỡ bỏ hoặc nâng cấp gói phần mềm một cách dễ dàng."
                        echo "   - **Tìm kiếm phần mềm:**"
                        echo "     + Bạn có thể tìm kiếm các gói phần mềm từ các kho phần mềm đã cấu hình."
                        echo ""

                        echo "3. Các lệnh cơ bản của yum:"
                        echo "   - **yum install <package>**: Cài đặt gói phần mềm từ kho phần mềm."
                        echo "   - **yum remove <package>**: Gỡ bỏ một gói phần mềm."
                        echo "   - **yum update**: Cập nhật tất cả các gói phần mềm đã cài đặt lên phiên bản mới nhất."
                        echo "   - **yum upgrade**: Nâng cấp các gói phần mềm và các gói phụ thuộc của chúng."
                        echo "   - **yum search <package>**: Tìm kiếm gói phần mềm trong kho phần mềm."
                        echo "   - **yum list installed**: Liệt kê tất cả các gói phần mềm đã cài đặt."
                        echo "   - **yum clean all**: Dọn dẹp các file tạm thời và bộ nhớ cache của yum."
                        echo ""

                        echo "4. Quản lý kho phần mềm (Repositories):"
                        echo "   - Kho phần mềm (repo) là các máy chủ lưu trữ các gói phần mềm mà yum có thể truy cập."
                        echo "   - Các tệp cấu hình kho phần mềm thường được lưu trữ tại /etc/yum.repos.d/."
                        echo "   - Bạn có thể thêm kho phần mềm mới bằng cách chỉnh sửa hoặc tạo các tệp cấu hình repo."
                        echo ""

                        echo "5. Lợi ích của yum:"
                        echo "   - **Quản lý phụ thuộc tự động:**"
                        echo "     + Yum tự động cài đặt các gói phụ thuộc khi cài đặt một gói phần mềm."
                        echo "   - **Tiết kiệm thời gian:**"
                        echo "     + Việc cài đặt, nâng cấp, và gỡ bỏ phần mềm dễ dàng và nhanh chóng thông qua lệnh yum."
                        echo "   - **Tính tương thích cao:**"
                        echo "     + Yum hỗ trợ nhiều loại gói phần mềm và kho phần mềm khác nhau, giúp người dùng dễ dàng cập nhật và quản lý hệ thống của họ."
                        echo ""

                        echo "6. Các công cụ thay thế yum:"
                        echo "   - **dnf**: Là công cụ quản lý gói thay thế yum trong các phiên bản mới hơn của Fedora và RHEL 8+. DNF cung cấp nhiều tính năng giống như yum nhưng có hiệu suất cao hơn."
                        echo "   - **rpm**: Là công cụ quản lý gói cấp thấp, chỉ được sử dụng để cài đặt, gỡ bỏ và quản lý gói RPM mà không giải quyết phụ thuộc."
                        echo ""

                        echo "============================================"
                        echo "            Tổng kết về yum                "
                        echo "============================================"
                        echo "   Yum là công cụ quản lý gói mạnh mẽ và linh hoạt cho các hệ thống Linux dựa trên RPM,"
                        echo "   giúp người dùng dễ dàng cài đặt, cập nhật, và quản lý phần mềm, đồng thời hỗ trợ quản lý kho phần mềm."
                        echo "============================================"
                     ;;
                     10)
                        echo "============================================"
                        echo "             Shell Linux                    "
                        echo "============================================"

                        echo ""
                        echo "1. Định nghĩa về Shell:"
                        echo "   - Shell trong Linux là một chương trình giao diện dòng lệnh, cho phép người dùng tương tác với hệ điều hành."
                        echo "   - Shell nhận lệnh từ người dùng, thực thi các lệnh đó và trả lại kết quả."
                        echo "   - Shell cung cấp một môi trường để thực hiện các tác vụ như quản lý tệp, chạy các chương trình, và tự động hóa công việc."
                        echo ""

                        echo "2. Các loại Shell phổ biến trong Linux:"
                        echo "   - **Bash (Bourne Again Shell):**"
                        echo "     + Là shell mặc định trên nhiều phân phối Linux, mạnh mẽ và dễ sử dụng, hỗ trợ nhiều tính năng như điều khiển dòng lệnh và scripting."
                        echo "   - **Zsh (Z Shell):**"
                        echo "     + Shell tương tự Bash nhưng cung cấp nhiều tính năng nâng cao như tự động hoàn thành và điều khiển dòng lệnh mạnh mẽ hơn."
                        echo "   - **Fish (Friendly Interactive Shell):**"
                        echo "     + Được thiết kế để dễ sử dụng và dễ dàng tương tác, với nhiều tính năng tự động và cấu hình mặc định hợp lý."
                        echo "   - **Csh (C Shell):**"
                        echo "     + Shell với cú pháp giống C, ít được sử dụng hơn trong môi trường Linux."
                        echo ""

                        echo "3. Các chức năng chính của Shell:"
                        echo "   - **Thực thi lệnh:** Shell cho phép người dùng thực thi các lệnh hệ thống."
                        echo "   - **Quản lý tệp và thư mục:** Shell hỗ trợ các lệnh như ls, cp, mv, rm, mkdir, v.v., để quản lý tệp và thư mục."
                        echo "   - **Scripting:** Shell hỗ trợ lập trình qua việc sử dụng các script (tệp chứa lệnh). Điều này giúp tự động hóa các công việc thường xuyên."
                        echo "   - **Quản lý tiến trình:** Shell cho phép người dùng quản lý các tiến trình, như ps, top, kill."
                        echo ""

                        echo "4. Cấu trúc Shell Script:"
                        echo "   - Shell script là một tệp văn bản chứa các lệnh mà Shell sẽ thực thi khi chạy."
                        echo "   - Mỗi dòng trong script là một lệnh hoặc một câu lệnh điều kiện, vòng lặp, hoặc khai báo biến."
                        echo "   - Ví dụ một script đơn giản:"
                        echo "     #!/bin/bash"
                        echo "     echo 'Hello, World!'"
                        echo ""

                        echo "5. Các lệnh phổ biến trong Shell Linux:"
                        echo "   - **ls**: Liệt kê các tệp và thư mục trong thư mục hiện tại."
                        echo "   - **cd**: Thay đổi thư mục làm việc."
                        echo "   - **pwd**: Hiển thị thư mục làm việc hiện tại."
                        echo "   - **cp**: Sao chép tệp hoặc thư mục."
                        echo "   - **mv**: Di chuyển hoặc đổi tên tệp/thư mục."
                        echo "   - **rm**: Xóa tệp hoặc thư mục."
                        echo "   - **cat**: Hiển thị nội dung của tệp."
                        echo "   - **echo**: Hiển thị thông điệp hoặc giá trị của biến."
                        echo "   - **man**: Hiển thị tài liệu hướng dẫn sử dụng cho các lệnh."
                        echo ""

                        echo "6. Biến trong Shell:"
                        echo "   - Biến trong Shell lưu trữ giá trị và có thể được sử dụng trong các lệnh hoặc script."
                        echo "   - Ví dụ khai báo biến và sử dụng:"
                        echo "     MY_VAR='Hello'"
                        echo "     echo $MY_VAR"
                        echo ""

                        echo "7. Tính năng mạnh mẽ của Shell:"
                        echo "   - **Pipes và Redirects:** Shell cho phép kết hợp các lệnh với nhau qua pipes (|) và chuyển hướng đầu vào/đầu ra (>, >>, <s)."
                        echo "   - **Vòng lặp và Điều kiện:** Shell hỗ trợ cấu trúc điều kiện (if-else) và vòng lặp (for, while, until)."
                        echo "   - **Quản lý tệp:** Shell cho phép tự động sao lưu, nén, giải nén tệp thông qua các lệnh như tar, gzip, zip."
                        echo ""

                        echo "============================================"
                        echo "               Tổng kết về Shell           "
                        echo "============================================"
                        echo "   Shell trong Linux là một công cụ mạnh mẽ giúp người dùng tương tác với hệ thống, tự động hóa công việc và quản lý các tác vụ hàng ngày."
                        echo "   Việc sử dụng shell hiệu quả có thể giúp nâng cao năng suất và quản lý hệ thống tốt hơn."
                        echo "============================================"

                     ;;
                     11)

                    echo "============================================"
                    echo "             Làm việc với các tệp          "
                    echo "============================================"

                    echo ""
                    echo "1. Định nghĩa về tệp trong Linux:"
                    echo "   - Tệp trong Linux là một đơn vị lưu trữ dữ liệu trên hệ thống, có thể chứa văn bản, hình ảnh, âm thanh hoặc bất kỳ dữ liệu nào khác."
                    echo "   - Mọi thứ trong Linux đều được xem như một tệp, bao gồm tệp thông thường, thư mục, thiết bị, và liên kết."
                    echo "   - Mỗi tệp có các thuộc tính như quyền truy cập, chủ sở hữu, nhóm, kích thước và ngày sửa đổi cuối cùng."
                    echo ""

                    echo "2. Các loại tệp trong Linux:"
                    echo "   - **Tệp thông thường:** Tệp chứa dữ liệu, như văn bản, hình ảnh, video, v.v."
                    echo "   - **Thư mục (Directory):** Thư mục là tệp đặc biệt chứa các tệp con khác."
                    echo "   - **Liên kết (Link):** Liên kết là một tệp đặc biệt, trỏ đến một tệp khác."
                    echo "   - **Tệp thiết bị:** Đại diện cho phần cứng hoặc thiết bị hệ thống (ví dụ: ổ đĩa cứng, ổ đĩa quang)."
                    echo "   - **Tệp đặc biệt:** Chứa dữ liệu hoặc chương trình hệ thống, ví dụ: tệp FIFO hoặc tệp socket."
                    echo ""

                    echo "3. Các lệnh cơ bản để làm việc với tệp:"
                    echo "   - **ls**: Liệt kê các tệp và thư mục trong thư mục hiện tại."
                    echo "   - **cd**: Chuyển đến thư mục khác."
                    echo "   - **cp**: Sao chép tệp hoặc thư mục từ nguồn đến đích."
                    echo "   - **mv**: Di chuyển hoặc đổi tên tệp/thư mục."
                    echo "   - **rm**: Xóa tệp hoặc thư mục."
                    echo "   - **touch**: Tạo một tệp mới hoặc thay đổi thời gian sửa đổi của tệp."
                    echo "   - **cat**: Hiển thị nội dung của tệp trên màn hình."
                    echo "   - **head**: Hiển thị phần đầu của tệp."
                    echo "   - **tail**: Hiển thị phần cuối của tệp."
                    echo "   - **find**: Tìm kiếm tệp theo tên, loại, kích thước hoặc các thuộc tính khác."
                    echo ""

                    echo "4. Các lệnh liên quan đến quyền tệp:"
                    echo "   - **chmod**: Thay đổi quyền truy cập của tệp (đọc, ghi, thực thi)."
                    echo "   - **chown**: Thay đổi chủ sở hữu hoặc nhóm của tệp."
                    echo "   - **chgrp**: Thay đổi nhóm của tệp."
                    echo "   - **umask**: Thiết lập quyền mặc định cho các tệp mới tạo."
                    echo ""

                    echo "5. Làm việc với các tệp văn bản:"
                    echo "   - **echo**: Ghi văn bản vào tệp."
                    echo "     Ví dụ: echo 'Hello World' > file.txt"
                    echo "   - **cat**: Hiển thị nội dung của tệp văn bản."
                    echo "     Ví dụ: cat file.txt"
                    echo "   - **grep**: Tìm kiếm văn bản trong tệp."
                    echo "     Ví dụ: grep 'pattern' file.txt"
                    echo "   - **sed**: Chỉnh sửa văn bản trong tệp."
                    echo "     Ví dụ: sed 's/old/new/g' file.txt"
                    echo "   - **awk**: Xử lý và trích xuất thông tin từ tệp văn bản."
                    echo "     Ví dụ: awk '{print $1}' file.txt"
                    echo ""

                    echo "6. Quản lý tệp nén:"
                    echo "   - **tar**: Tạo hoặc giải nén tệp tarball."
                    echo "     Ví dụ: tar -cvf archive.tar file1 file2"
                    echo "   - **gzip**: Nén tệp."
                    echo "     Ví dụ: gzip file.txt"
                    echo "   - **gunzip**: Giải nén tệp nén gzip."
                    echo "     Ví dụ: gunzip file.txt.gz"
                    echo "   - **zip**: Nén tệp thành tệp zip."
                    echo "     Ví dụ: zip archive.zip file1 file2"
                    echo "   - **unzip**: Giải nén tệp zip."
                    echo "     Ví dụ: unzip archive.zip"
                    echo ""

                    echo "7. Tạo tệp mới và thay đổi thời gian sửa đổi:"
                    echo "   - **touch**: Tạo một tệp mới hoặc thay đổi thời gian sửa đổi của tệp."
                    echo "     Ví dụ: touch newfile.txt"
                    echo ""

                    echo "8. Liên kết tệp:"
                    echo "   - **ln**: Tạo liên kết giữa các tệp."
                    echo "     - Liên kết cứng (hard link): Liên kết trực tiếp đến inode của tệp."
                    echo "     - Liên kết mềm (symbolic link): Liên kết đến đường dẫn của tệp."
                    echo "     Ví dụ: ln -s /path/to/file link_name"
                    echo ""

                    echo "9. Xóa tệp:"
                    echo "   - **rm**: Xóa tệp hoặc thư mục."
                    echo "     Ví dụ: rm file.txt"
                    echo "   - **rm -r**: Xóa thư mục và các tệp con của nó."
                    echo "     Ví dụ: rm -r dir_name"
                    echo "   - **rm -f**: Xóa tệp mà không hỏi xác nhận."
                    echo "     Ví dụ: rm -f file.txt"
                    echo ""

                    echo "============================================"
                    echo "               Tổng kết về tệp             "
                    echo "============================================"
                    echo "   Làm việc với tệp là một kỹ năng cơ bản và quan trọng trong Linux, giúp bạn quản lý và thao tác với dữ liệu hiệu quả."
                    echo "   Việc nắm vững các lệnh làm việc với tệp sẽ giúp bạn tăng hiệu quả công việc và quản lý hệ thống tốt hơn."
                    echo "============================================"
                     ;;
                esac
        }
        config_noidungfielsystem
        ;;
        7)
            echo "Bạn đã chọn Quản lý máy in."
            config_printter() {
                echo " 1) Cai Dat va Cấu hình Máy in qua CUPS "
                echo " 2) Chia sẻ máy in qua mạng "
                echo " 3) Cấu hình xác thực người dùng "
                echo " 4) Giới hạn quyền in theo thời gian " 
                echo " 5) Kích hoạt và cấu hình TLS " 
                read -p "Chon chuc nang: " choice

                case $choice in
                    1)
                        echo "Cấu hình và quản lý máy in với CUPS"
                            sudo apt update
                            sudo apt install -y cups
                            sudo systemctl start cups
                            sudo systemctl enable cups
                            read -p "Nhập tên người dùng để thêm vào nhóm lpadmin: " USERNAME
                            sudo usermod -aG lpadmin $USERNAME
                            sudo systemctl status cups
                            echo "CUPS đã được cài đặt. Truy cập http://localhost:631 để thêm và quản lý máy in."
                        ;;
                    2)
                        echo "Cấu hình chia sẻ máy in qua mạng với CUPS"

                   
                            sudo sed -i 's/^#\(Browsing On\)/\1/' /etc/cups/cupsd.conf
                            sudo sed -i 's/^#\(BrowseLocalProtocols\)/\1/' /etc/cups/cupsd.conf
                            sudo sed -i 's/^#\(Listen.*\)/\1/' /etc/cups/cupsd.conf 
                            sudo sed -i '/<Location \/>/,/<\/Location>/ s/Require local/Require all granted/' /etc/cups/cupsd.conf
                            sudo systemctl restart cups

                            echo "Máy in đã được chia sẻ qua mạng. Kiểm tra tại http://<IP_MÁY_CHỦ>:631"
                            ;;
                    3)

                        echo "Cấu hình xác thực người dùng trên CUPS"

                   
                                sudo sed -i '/<Location \/>/,/<\/Location>/ s/Require all granted/Require valid-user/' /etc/cups/cupsd.conf
                                read -p "Nhập tên người dùng CUPS: " CUPS_USER
                                sudo lppasswd -a $CUPS_USER                            
                                sudo systemctl restart cups
                                echo "Xác thực người dùng đã được kích hoạt. Bạn cần cung cấp tài khoản khi in."
                                ;;
                    4)


                       echo "Cấu hình giới hạn thời gian in ấn"

                                sudo bash -c "cat > /usr/local/bin/enable_printer.sh <<'EOF'

                                        PRINTER_NAME=\$1
                                        if [ -z "\$PRINTER_NAME" ]; then
                                        echo "Usage: \$0 <printer_name>"
                                        exit 1
                                        fi
                                        sudo lpadmin -p \$PRINTER_NAME -E
                                        echo "Máy in \$PRINTER_NAME đã được bật."
                                        EOF"

                                sudo bash -c "cat > /usr/local/bin/disable_printer.sh <<'EOF'

                                    PRINTER_NAME=\$1
                                    if [ -z "\$PRINTER_NAME" ]; then
                                    echo "Usage: \$0 <printer_name>"
                                    exit 1
                                    fi
                                    sudo cupsdisable \$PRINTER_NAME
                                    echo "Máy in \$PRINTER_NAME đã bị vô hiệu hóa."
                                    EOF"

                    
                    sudo chmod +x /usr/local/bin/enable_printer.sh /usr/local/bin/disable_printer.sh

                    
                    read -p "Nhập tên máy in cần giới hạn thời gian: " PRINTER
                    (crontab -l 2>/dev/null; echo "0 8 * * * /usr/local/bin/enable_printer.sh $PRINTER") | crontab -
                    (crontab -l 2>/dev/null; echo "0 18 * * * /usr/local/bin/disable_printer.sh $PRINTER") | crontab -

                    echo "Máy in $PRINTER sẽ chỉ hoạt động từ 8:00 sáng đến 6:00 chiều."

                    ;;
                    5)
                    echo "Cấu hình bảo mật TLS cho CUPS"

                            # Tạo thư mục chứa chứng chỉ SSL
                            SSL_DIR="/etc/cups/ssl"
                            sudo mkdir -p $SSL_DIR

                            # Tạo chứng chỉ tự ký
                            sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
                            -keyout $SSL_DIR/cups.key -out $SSL_DIR/cups.crt \
                            -subj "/C=US/ST=State/L=City/O=Example/OU=IT/CN=$(hostname)"

                            # Cập nhật quyền
                            sudo chmod 600 $SSL_DIR/cups.key

                            # Cấu hình CUPS sử dụng TLS
                            sudo sed -i 's/^#\(ServerCertificate\)/\1/' /etc/cups/cupsd.conf
                            sudo sed -i 's/^#\(ServerKey\)/\1/' /etc/cups/cupsd.conf
                            sudo bash -c "echo 'ServerCertificate $SSL_DIR/cups.crt' >> /etc/cups/cupsd.conf"
                            sudo bash -c "echo 'ServerKey $SSL_DIR/cups.key' >> /etc/cups/cupsd.conf"

                            # Khởi động lại dịch vụ
                            sudo systemctl restart cups

                            echo "TLS đã được kích hoạt. Truy cập https://<IP_MÁY_CHỦ>:631 để quản lý."


                    ;;
                    esac
                            }
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
                            echo "Sql Server"
                            config_sqlserver() {
                                echo  " Ban muon chon tinh nang nao "
                                echo " 1) cai dat SQL Server "
                                echo " 2) Su Dung SQL Server "
                                read -p " Ban co the chon 1 hoac 2 " chon
                                case $chon in
                                    1)
                                        echo "Cai dat SQL Server "
                                        sudo apt update -y >> /dev/null 2>&1
                                        sudo apt install -y curl gnupg >> /dev/null 2>&1
                                        curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
                                        sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/mssql-server-2022.list)"
                                        sudo apt update -y >> /dev/null 2>&1
                                        sudo apt install -y mssql-server  >> /dev/null 2>&1
                                        echo " Chon phien ban ma ban muon "
                                        sudo /opt/mssql/bin/mssql-conf setup
                                        systemctl status mssql-server
                                        ;;
                                    2)
                                        echo " Su dung SQL Server "
                                        echo " 1) Ket noi SQL Server "
                                        echo " 2) Cai dat SQL server bang docker "
                                        echo " 3) thuc hien cau lenh tu file "
                                        read -p "Ban co the chon 1, 2 hoac 3 " chon
                                        case $chon in
                                            1)
                                            echo "Ket noi SQL Server "
                                            sudo apt-get install -y mssql-tools unixodbc-dev
                                            sqlcmd -S localhost -U sa -P "your_password"
                                            ;;
                                            2)
                                            echo "Cai dat SQL Server bang docker " 
                                            sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=your_password' -e 'MSSQL_PID=Express' -p 14
                                            3306:1433 -d mcr.microsoft.com/mssql/server:2022-latest
                                            ;;
                                            3)
                                            echo "Thuc hien cau lenh tu file "
                                            echo " nhap dia chi cua file ma ban muon : "
                                            read -r link
                                            echo " Nhap container id : "
                                            read -r container_id
                                            echo " Nhap ten container : "
                                            read -r container_name 
                                            sudo docker cp $link container_id:/script.sql
                                            ;;
                                            *)
                                            echo "Lựa chọn không hợp lệ. Vui lòng thử lại."
                                            ;;
                                    esac
                                    ;;
                                    *)
                                    echo "Lựa chọn không hợp lệ. Vui lòng thử lại."
                                    ;; 
                            esac
                            }
                            config_sqlserver
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

                   



