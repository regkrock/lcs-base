Class {
	#name : 'LcsWarRabbitLibrayImporterExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WarRabbitLibraryTests-Examples',
	#package : 'Lcs-WarRabbitLibraryTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsWarRabbitLibrayImporterExamples >> importCategoryName [
	<gtExample>
	| importer stream libraryCategory |
	importer := self newImporter.
	self assert: importer currentCategory isNil.
	stream := ReadStream on: 'Crafts'.
	
	[stream atEnd] whileFalse: [
		importer importLine:  stream nextLine
		].
	self assert: importer items size equals: 1.
	libraryCategory := importer items first.
	self assert: libraryCategory categoryName = 'Crafts'.
	self assert: importer currentCategory identicalTo: libraryCategory
	
]

{ #category : 'examples' }
LcsWarRabbitLibrayImporterExamples >> importedBook [
	"<gtExample>"
	| importer stream |
	importer := self newImporter.
	stream := ReadStream
			on: 'Crafts
Bealer, Alex W. 	Art of Blacksmithing	(rev ed)			Castle 1969/76/95'.
	[ stream atEnd ]
		whileFalse: [ importer importLine: stream nextLine.
			self currentUnitOfWork applyChanges ].
	self assert: importer items size equals: 2.
	self assert: importer items first categoryName = 'Crafts'.
	self deny: importer items first identicalTo: importer items last.
	self assert: self currentSystem libraryCategories collection size = 1.
	self
		assert: self currentSystem libraryCategories collection any categoryName = 'Crafts'.
	self
		assert: importer items last libraryCategory
		identicalTo: importer items first
]

{ #category : 'testing' }
LcsWarRabbitLibrayImporterExamples >> importedCategoryNameTwice [
	<gtExample>
	| importer stream |
	importer := self newImporter.
	stream := ReadStream on: 'Crafts
Crafts'.
	[stream atEnd] whileFalse: [
		importer importLine:  stream nextLine.
		self currentUnitOfWork applyChanges.
		].
	self assert: importer items size equals: 2.
	self assert: importer items first categoryName = 'Crafts'.
	"self assert: importer items first identicalTo: importer items last."
	"self assert: self currentSystem libraryCategories collection size = 1."
	self assert: self currentSystem libraryCategories collection any categoryName = 'Crafts'.
]

{ #category : 'examples' }
LcsWarRabbitLibrayImporterExamples >> importedPaperbackBook [
	"<gtExample>"
	| importer stream |
	importer := LcsWarRabbitLibrayImporter newOn: self currentSystem.
	stream := ReadStream on: 'Crafts
Jenkins, J. Geraint	Traditional Country Craftsmen (rev ed)			pb	RKP 1965/78'.
	[stream atEnd] whileFalse: [
		importer importLine:  stream nextLine.
		self currentUnitOfWork applyChanges.
		].
	self assert: (importer items last isKindOf: LcsBook)
]

{ #category : 'examples' }
LcsWarRabbitLibrayImporterExamples >> newImporter [
	<gtExample>
	self ensureCurrentSystemIsWarRabbitLibrarySystem.
	^ LcsWarRabbitLibrayImporter newOn: self currentSystem
]
