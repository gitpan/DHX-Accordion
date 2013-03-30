package DHX::Accordion;

use Moose;
use CAM::XML;

=head1 NAME

DHX::Accordion - XML generator for dhtmlxAccordion

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use DHX::Accordion;
    
    my $accordion = DHX::Accordion->new;
       
    $accordion->cell(
        {
            id => 'a1',
            height => '120'
            text => 'Main Page'
        },
        {
            id => 'a2',
            open => 'true',
            text => 'Site Navigation'
        }
    );
    
    $accordion->cell(
        {
            id => 'a3',
            icon => 'icon2.gif',
            text => 'Support &amp; Feedback'
        }
    );
    
    $accordion->cell(
        {
            id => 'a4',
            icon => 'icon3.gif',
            text => 'Comments'
        }
    );
    
    print "Content-type: application/xml; charset=utf8\n\n";
    print $accordion->result;
    
=cut

# skin
has 'skin' => (
    is => 'rw',
    isa => 'Str',
    default => 'dhx_skyblue'
);

# mode
has 'mode' => (
    is => 'rw',
    isa => 'Str',
    default => 'single'
);

# iconsPath
has 'iconsPath' => (
    is => 'rw',
    isa => 'Str',
    default => '../common/'
);

# openEffect
has 'openEffect' => (
    is => 'rw',
    isa => 'Str',
    default => 'false'
);

# accordion
has 'accordion' => (
    is => 'rw',
    default => sub {
        CAM::XML->new('accordion');
    }
);

# add cell
sub cell {
    my $self = shift;
    
    foreach my $row (@_){
        my $cell = CAM::XML->new('cell');
        while(my ($key, $value) = each($row)){
            if($key eq 'text'){
                $cell->add(-text => $value);
            }else{
                $cell->setAttributes($key, $value);
            }
        }
        $self->accordion->add($cell);
    }
}

# print result
sub result {
    my $self = shift;
    $self->accordion->setAttributes('skin', $self->skin);
    $self->accordion->setAttributes('mode', $self->mode);
    $self->accordion->setAttributes('iconsPath', $self->iconsPath);
    $self->accordion->setAttributes('openEffect', $self->openEffect);
    return $self->accordion->header, $self->accordion->toString;
}

1;
    
=head1 INSTANCE METHODS

=over

=item $accordion->skin('dhx_terrace');

Set skin dhtmlxAccordion. Default dhx_skyblue

=item $accordion->mode('multi');

Set mode dhtmlxAccordion. Default single

=item $accordion->iconsPath('/static/icons/');

Set iconsPath dhtmlxAccordion. Default ../common/

=item $accordion->openEffect('true');

Set openEffect dhtmlxAccordion. Default false

=item $accordion->cell({foo_key => foo_value, bar_key => bar_value});

Set cells dhtmlxAccorsion

=item $accordion->result;

get result xml dhtml.

=back

=head1 LICENSE

opensouce

=head1 AUTHOR

Lucas Tiago de Moraes - lucastiagodemoraes@gmail.com
