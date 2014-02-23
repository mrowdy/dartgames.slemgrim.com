<?php if(function_exists('previous_link') && function_exists('next_link')): ?>
    <div class="container">
        <footer class="pagination">
            <?php previous_link(); ?>
            <?php next_link(); ?>
        </footer>
    </div>
<?php endif; ?>