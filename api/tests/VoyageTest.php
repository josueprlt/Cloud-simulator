<?php declare(strict_types=1);

use PHPUnit\Framework\TestCase;
use App\Entity\Voyage;

final class VoyageTest extends TestCase
{
    /** @test */
    public function greet(): void
    {
        $voyage = new Voyage();
        $voyage->setTitle('Hello');
        $this->assertSame($voyage->getTitle(),'Hello');
    }
}
