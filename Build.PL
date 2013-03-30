use Module::Build;
Module::Build->new(
   module_name => 'DHX::Accordion',
   dist_author => 'Lucas Tiago de Moraes - lucastiagodemoraes@gmail.com',
   license => 'opensouce',
   requires => {
      'perl'                     => '5.006',
      'Moose'                    => '',
      'CAM::XML'                 => ''
   },
   build_requires => {
      'Test::More'               => '0.01',
   },
)->create_build_script;