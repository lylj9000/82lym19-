监听TRX（波场）地址的脚本通常涉及使用相应的区块链 API 或节点，因为你需要获取实时的交易信息。以下是一个简单的示例，使用Node.js和TronLink API：

首先，确保你安装了Node.js。接下来，使用以下步骤：

创建一个新目录，并在终端中进入该目录：
bash
Copy code
mkdir trx-address-listener
cd trx-address-listener
初始化你的 Node.js 项目：
bash
Copy code
npm init -y
安装 axios（用于进行 HTTP 请求）：
bash
Copy code
npm install axios
创建一个脚本文件（例如 listener.js），并使用你喜欢的文本编辑器打开它：
javascript
Copy code
const axios = require('axios');

const trxAddress = 'YOUR_TRX_ADDRESS';
const tronLinkAPI = 'https://api.tronlink.org/v1/accounts/';

async function checkBalance() {
    try {
        const response = await axios.get(tronLinkAPI + trxAddress);
        const balance = response.data.data.balance / 1e6; // Convert from SUN to TRX
        console.log(`Balance for ${trxAddress}: ${balance} TRX`);
    } catch (error) {
        console.error('Error fetching balance:', error.message);
    }
}

// Check balance initially
checkBalance();

// Set interval for periodic balance checking (e.g., every 5 minutes)
setInterval(checkBalance, 5 * 60 * 1000);
替换 'YOUR_TRX_ADDRESS' 为你要监听的 TRX 地址。
运行脚本：
bash
Copy code
node listener.js
这个脚本会获取指定 TRX 地址的余额，并每隔一段时间重复检查。请注意，这只是一个简单的示例，实际应用可能需要更多的功能，比如处理交易、通知等。确保你的行为符合法律法规和 API 使用的条款。