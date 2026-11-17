<?php
/** @var string $activeNav */
/** @var array<string, int|float>|null $navBadges */

$activeNav = $activeNav ?? 'dashboard';
$navBadges = $navBadges ?? [];
?>
<div class="admin-shell" data-admin-shell>
    <?php include base_path('views/admin/partials/sidebar.php'); ?>
    <div class="admin-nav-backdrop" data-admin-nav-backdrop hidden></div>

    <div class="admin-main">
        <header class="admin-topbar d-lg-none">
            <button type="button"
                    class="admin-topbar-toggle"
                    data-admin-nav-toggle
                    aria-controls="adminSidebar"
                    aria-expanded="false"
                    aria-label="<?= e(__('nav.open_menu')) ?>">
                <i class="bi bi-list" aria-hidden="true"></i>
            </button>
            <div class="admin-topbar-brand">
                <span class="admin-topbar-logo" aria-hidden="true">
                    <?php
                    $brandVariant = 'icon';
                    $brandClass = 'brand-mark-icon-sm';
                    include base_path('views/partials/brand-mark.php');
                    ?>
                </span>
                <span><?= e(__('admin.brand')) ?></span>
            </div>
        </header>

        <div class="admin-content">
            <?php if (!empty($success)): ?>
                <div class="admin-alert admin-alert-success" role="status"><?= e((string) $success) ?></div>
            <?php endif; ?>
            <?php if (!empty($error)): ?>
                <div class="admin-alert admin-alert-error" role="alert"><?= e((string) $error) ?></div>
            <?php endif; ?>

            <?php if (!empty($pageTitle) && ($activeNav ?? '') !== 'dashboard'): ?>
                <header class="admin-page-head">
                    <h1 class="admin-page-title"><?= e($pageTitle) ?></h1>
                </header>
            <?php endif; ?>
