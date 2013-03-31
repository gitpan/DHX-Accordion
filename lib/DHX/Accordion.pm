package DHX::Accordion;

use Moose;
use XML::LibXML;

=head1 NAME

DHX::Accordion - XML generator for dhtmlxAccordion

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';

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
    
    print "Content-type: application/xml; charset=". $accordion->encoding ."\n\n";
    print $accordion->result;
    
=cut

# encoding
has 'encoding' => (
    is => 'rw',
    isa => 'Str',
    default => 'utf-8'
);

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

# cells
has 'cells' => (
    is => 'rw',
    isa => 'ArrayRef'
);

sub cell {
    my $self  = shift;
    
    if(scalar($self->cells)){
        my @newcells = @{$self->cells};
        push(@newcells, @_);
        $self->cells(\@newcells);
    }else{
        $self->cells(\@_);
    }
}

sub result {
    my $self = shift;
    
    my $document = XML::LibXML::Document->new('1.0', $self->encoding);
    
    my $accordion = $document->createElement('accordion');
    
    $accordion->setAttribute('skin' => $self->skin);
    
    $accordion->setAttribute('mode' => $self->mode);
    
    $accordion->setAttribute('iconsPath' => $self->iconsPath);
    
    $accordion->setAttribute('openEffect' => $self->openEffect);
    
    if($self->cells){
        
        foreach my $row (@{$self->cells}){
            
            my $cell = $document->createElement('cell');
            
            while(my ($key, $value) = each($row)){
                
                if($key eq 'text'){
                    $cell->appendTextNode($value);
                }else{
                    $cell->setAttribute($key, $value);
                }
                
            }
            
            $accordion->appendChild($cell);
        }
    }
    
    $document->setDocumentElement($accordion);
    
    $document->toString(shift);
}

1;

=head1 INSTANCE METHODS

=over

=item $accordion->encoding('iso-8859-1');

Set encoding dhtmlxAccordion. Default utf-8

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

=item $accordion->result(1);

get result xml dhtml. Default 0

0 - than the document is dumped as it was originally parsed

1 - will add ignorable white spaces, so the nodes content is easier to read. Existing text nodes will not be altered

=back

=head1 LICENSE

opensouce

=head1 AUTHOR

Lucas Tiago de Moraes - lucastiagodemoraes@gmail.com
