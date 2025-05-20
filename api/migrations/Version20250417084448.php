<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250417084448 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Creation table trip';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE trip (id SERIAL NOT NULL, string VARCHAR(255) NOT NULL, description TEXT NOT NULL, start_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, end_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, thumbnail VARCHAR(255) NOT NULL, is_archive BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE TABLE user_trip (trip_id INT NOT NULL, user_id INT NOT NULL, PRIMARY KEY(trip_id, user_id))');
        $this->addSql('CREATE INDEX IDX_CD7B9F2A5BC2E0E ON user_trip (trip_id)');
        $this->addSql('CREATE INDEX IDX_CD7B9F2A76ED395 ON user_trip (user_id)');
        $this->addSql('ALTER TABLE user_trip ADD CONSTRAINT FK_CD7B9F2A5BC2E0E FOREIGN KEY (trip_id) REFERENCES trip (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE user_trip ADD CONSTRAINT FK_CD7B9F2A76ED395 FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE user_trip DROP CONSTRAINT FK_CD7B9F2A5BC2E0E');
        $this->addSql('ALTER TABLE user_trip DROP CONSTRAINT FK_CD7B9F2A76ED395');
        $this->addSql('DROP TABLE trip');
        $this->addSql('DROP TABLE user_trip');
    }
}
