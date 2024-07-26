# URL chứa danh sách các URL proxy SOCKS4
$proxyListUrl = "https://raw.githubusercontent.com/werearecat/proxy-gen/main/proxy4-url"

# Lấy nội dung từ URL chứa danh sách proxy URLs
$proxyUrls = Invoke-RestMethod -Uri $proxyListUrl

# Khởi tạo một mảng để lưu nội dung từ các proxy URLs
$allProxies = @()

# Lặp qua từng URL trong danh sách
foreach ($proxyUrl in $proxyUrls) {
    try {
        # Lấy nội dung từ mỗi URL proxy SOCKS4
        $proxyContent = Invoke-RestMethod -Uri $proxyUrl
        # Thêm nội dung vào mảng
        $allProxies += $proxyContent
    }
    catch {
        Write-Output "Không thể tải nội dung từ $proxyUrl"
    }
}

# Ghi tất cả nội dung vào file proxy.txt
$allProxies | Out-File -FilePath "proxy.txt"
