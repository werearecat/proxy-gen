# Định nghĩa đường dẫn tới file chứa các URL
$filePath = "$env:temp\proxy-gen.dat"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/werearecat/proxy-gen/main/proxy4-url" -OutFile $filePath
# Đọc nội dung của file vào một mảng
$fileContent = Get-Content -Path $filePath

# Khởi tạo một danh sách để lưu nội dung từ các URL
$allProxies = @()

# Lặp qua từng dòng trong file
foreach ($line in $fileContent) {
    # Kiểm tra xem dòng có phải là URL hợp lệ không
    if ($line -match "^https?://") {
        try {
            # Lấy nội dung từ mỗi URL
            $proxyContent = Invoke-RestMethod -Uri $line
            
            # Thêm nội dung vào danh sách
            $allProxies += $proxyContent
        }
        catch {
            Write-Output "Không thể tải nội dung từ $line"
        }
    }
}

# Ghi tất cả nội dung vào file proxy4.txt
if ($allProxies.Count -gt 0) {
    $allProxies | Out-File -FilePath "proxy4.txt"
    Write-Output "Nội dung đã được ghi vào file proxy4.txt"
} else {
    Write-Output "Không có dữ liệu để ghi vào file proxy4.txt"
}
