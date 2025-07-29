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
