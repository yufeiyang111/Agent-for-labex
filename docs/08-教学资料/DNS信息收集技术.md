# DNS信息收集技术

## DNS查询工具

### dig命令
```bash
dig example.com
dig +trace example.com
dig example.com MX
dig example.com AXFR
```

### dnsenum
```bash
dnsenum example.com
```

## 子域名发现

### 被动收集
```bash
curl -s \"https://crt.sh/?q=%.example.com\"
amass enum -passive -d example.com
```

### 主动扫描
```bash
gobuster dns -d example.com -w wordlist.txt
ffuf -w wordlist.txt -u https://FUZZ.example.com
```

## DNS区域传送

### 检测
```bash
dig @ns1.example.com example.com AXFR
```

## DNS数据利用

1. 建立目标资产清单
2. 发现隐藏服务
3. 识别CDN和WAF
4. 社工攻击面分析'