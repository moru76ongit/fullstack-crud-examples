#!/bin/bash

echo "Creando estructura de proyectos..."

# 1. PHP
mkdir -p php-crud-sqlserver/{config,uploads}
cat > php-crud-sqlserver/config/database.ini << 'EOF'
[sqlserver]
server = "localhost"
database = "testdb"
username = "sa"
password = "TuPassword123"
EOF

cat > php-crud-sqlserver/index.php << 'EOF'
<?php
\$config = parse_ini_file('config/database.ini', true);
\$server = \$config['sqlserver']['server'];
\$database = \$config['sqlserver']['database'];
\$uid = \$config['sqlserver']['username'];
\$pwd = \$config['sqlserver']['password'];

\$connectionInfo = array("Database" => \$database, "UID" => \$uid, "PWD" => \$pwd);
\$conn = sqlsrv_connect(\$server, \$connectionInfo);

if (!\$conn) {
    die("Error de conexión: " . print_r(sqlsrv_errors(), true));
}

\$sql = "SELECT id, nombre, email FROM usuarios";
\$stmt = sqlsrv_query(\$conn, \$sql);
\$usuarios = [];
while (\$row = sqlsrv_fetch_array(\$stmt, SQLSRV_FETCH_ASSOC)) {
    \$usuarios[] = \$row;
}
sqlsrv_free_stmt(\$stmt);
sqlsrv_close(\$conn);
?>

<!DOCTYPE html>
<html>
<head>
    <title>CRUD PHP</title>
</head>
<body>
<h2>Usuarios</h2>
<a href="create.php">Crear Usuario</a> |
<a href="export_excel.php">Exportar a Excel</a> |
<a href="export_txt.php">Exportar a TXT</a> |
<a href="import_excel.php">Importar Excel</a> |
<a href="import_txt.php">Importar TXT</a>
<hr>
<table border="1">
    <tr><th>ID</th><th>Nombre</th><th>Email</th><th>Acciones</th></tr>
    <?php foreach (\$usuarios as \$u): ?>
    <tr>
        <td><?= \$u['id'] ?></td>
        <td><?= htmlspecialchars(\$u['nombre']) ?></td>
        <td><?= htmlspecialchars(\$u['email']) ?></td>
        <td>
            <a href="edit.php?id=<?= \$u['id'] ?>">Editar</a> |
            <a href="delete.php?id=<?= \$u['id'] ?>" onclick="return confirm('¿Borrar?')">Eliminar</a>
        </td>
    </tr>
    <?php endforeach; ?>
</table>
</body>
</html>
EOF

# (Puedes agregar los otros archivos PHP si lo deseas)

# 2. Node.js
mkdir -p nodejs-crud-sqlserver/{config,routes,controllers,middleware,public,uploads}
cat > nodejs-crud-sqlserver/config/database.ini << 'EOF'
SERVER=localhost
DATABASE=testdb
USER=sa
PASSWORD=TuPassword123
EOF

cat > nodejs-crud-sqlserver/package.json << 'EOF'
{
  "name": "nodejs-crud-sqlserver",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "mssql": "^9.2.0",
    "multer": "^1.4.5-latest",
    "xlsx": "^0.18.5",
    "dotenv": "^16.0.3"
  }
}
EOF

# 3. Python FastAPI
mkdir -p python-fastapi-crud/{app,routes,config,uploads,static/exports}
cat > python-fastapi-crud/config/database.ini << 'EOF'
[sqlserver]
server = localhost
database = testdb
username = sa
password = TuPassword123
port = 1433
EOF

cat > python-fastapi-crud/requirements.txt << 'EOF'
fastapi
uvicorn
pyodbc
python-multipart
python-dotenv
openpyxl
xlsxwriter
EOF

# 4. .NET + Angular
mkdir -p "angular-net8-crud/backend-dotnet"
mkdir -p "angular-net8-crud/frontend-angular/src/app"

# Archivo base
echo "Estructura creada. Ahora puedes copiar el código completo en cada carpeta."

echo "¡Listo! Ahora puedes:"
echo "1. Copiar el código que te envié en cada archivo"
echo "2. Hacer commit y push"
echo ""
echo "git add ."
echo 'git commit -m "Añadidos proyectos CRUD en múltiples tecnologías"'
echo "git push origin main"