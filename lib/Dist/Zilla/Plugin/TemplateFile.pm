package Dist::Zilla::Plugin::TemplateFile;
# ABSTRACT:  Use a file as a template when building a distribution

use Moose;
with qw/ 
    Dist::Zilla::Role::Plugin 
    Dist::Zilla::Role::BeforeBuild 
    Dist::Zilla::Role::TextTemplate 
    Dist::Zilla::Role::FileInjector 
/;

has filename => (
    is => 'rw',
    isa => 'Str',
    required => 1,
);


sub before_build {
    my $self = shift;
    my $template = Dist::Zilla::File::OnDisk->new( { name => $self->filename } );
    my $content = $self->fill_in_string( $template->content, { dist => $self->zilla } );
    $template->content($content);
    print $content; exit;
#    $self->add_file($template);
}


__PACKAGE__->meta->make_immutable;

1;
