# Подключите все iOS поды для Flutter
def flutter_install_all_ios_pods(flutter_application_path)
  require File.join(flutter_application_path, '.ios', 'Flutter', 'flutter_export_environment')
  # Укажите путь к другим подам Flutter
  flutter_root = File.join(flutter_application_path, '.ios', 'Flutter')
  # Добавление подов для всех плагинов
  if defined?(Flutter)
    pod 'Flutter', :path => flutter_root
    pod 'FlutterPluginRegistrant', :path => File.join(flutter_root, 'FlutterPluginRegistrant')
  end

  # Укажите дополнительные поды, если это необходимо
  # pod 'MyCustomPod', :path => 'path_to_my_custom_pod'
end


