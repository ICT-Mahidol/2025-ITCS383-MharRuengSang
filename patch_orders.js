const fs = require('fs');
const file = 'Implementations/Backend-NodeJS/src/routes/orders.js';
let content = fs.readFileSync(file, 'utf8');
const searchStr = 'ORDER BY o.created_at DESC\n    `, [req.params.customerId === "100" ? 1 : req.params.customerId]);';
const replaceStr = searchStr + `\n\n    for (let i = 0; i < rows.length; i++) {\n      const [items] = await db.query(\`\n        SELECT oi.*, mi.name as menu_item_name \n        FROM order_items oi \n        LEFT JOIN menu_items mi ON oi.menu_item_id = mi.id \n        WHERE oi.order_id = ?\n      \`, [rows[i].id]);\n      rows[i].order_items = items;\n    }`;
content = content.replace(searchStr, replaceStr);
fs.writeFileSync(file, content);
