<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250414101415 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'création tables dépense, activité, logement';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE accomodation (id SERIAL NOT NULL, expense_id INT NOT NULL, name VARCHAR(255) NOT NULL, type VARCHAR(255) NOT NULL, check_in TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, check_out TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, breakfast BOOLEAN NOT NULL, schedule TEXT DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_520D81B3DC4C396D ON accomodation (expense_id)');
        $this->addSql('COMMENT ON COLUMN accomodation.check_in IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN accomodation.check_out IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE TABLE activity (id SERIAL NOT NULL, expense_id INT NOT NULL, start_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, end_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, description TEXT NOT NULL, link VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_AC74095ADC4C396D ON activity (expense_id)');
        $this->addSql('COMMENT ON COLUMN activity.start_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN activity.end_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE TABLE expense (id SERIAL NOT NULL, title VARCHAR(255) NOT NULL, cost INT NOT NULL, is_payed BOOLEAN DEFAULT false NOT NULL, type VARCHAR(255) NOT NULL, picture VARCHAR(255) NOT NULL, PRIMARY KEY(id))');
        $this->addSql('ALTER TABLE accomodation ADD CONSTRAINT FK_520D81B3DC4C396D FOREIGN KEY (expense_id) REFERENCES expense (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE activity ADD CONSTRAINT FK_AC74095ADC4C396D FOREIGN KEY (expense_id) REFERENCES expense (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE accomodation DROP CONSTRAINT FK_520D81B3DC4C396D');
        $this->addSql('ALTER TABLE activity DROP CONSTRAINT FK_AC74095ADC4C396D');
        $this->addSql('DROP TABLE accomodation');
        $this->addSql('DROP TABLE activity');
        $this->addSql('DROP TABLE expense');
    }
}
