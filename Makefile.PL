    use ExtUtils::MakeMaker;
    WriteMakefile
      ('DISTNAME' => 'File-Type',
       'VERSION' => '0.11',
       'PL_FILES' => {},
       'PREREQ_PM' => {
			'Test::More' => '0.01',
			'IO::File' => '0.01',
			'File::Slurp' => '0.01',

		      },
      );
