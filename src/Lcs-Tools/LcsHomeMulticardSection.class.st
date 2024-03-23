Class {
	#name : #LcsHomeMulticardSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #'Lcs-Tools-Sections'
}

{ #category : #example }
LcsHomeMulticardSection >> aboutThisBookCard [
	"<gtSectionCard>"
	<gtExample>
	<notest>
	^ GtHomeCard page
		priority: 20;
		pageName: 'About this book';
		databaseName: self gtBookName;
		yourself
]

{ #category : #example }
LcsHomeMulticardSection >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	^ GtHomeCard page
		title: 'Glamorous Toolkit Book';
		description: 'Read the Glamorous Toolkit book';
		priority: 10;
		pageName: 'Glamorous Toolkit';
		databaseName: self gtBookName;
		yourself
]

{ #category : #example }
LcsHomeMulticardSection >> gtBookCardSection [
	<gtExample>
	<notest>
	^ self
]

{ #category : #accessing }
LcsHomeMulticardSection >> gtBookName [
	^ 'Lcs Book'
]

{ #category : #example }
LcsHomeMulticardSection >> gtTourCard [
	<gtExample>
	^ GtHomeCard job
		title: 'GtTour';
		description: 'Open the GtTour slideshow';
		priority: 20;
		block: [ GtPresenterSlideShow openInSpace: GtTour ];
		yourself
]

{ #category : #accessing }
LcsHomeMulticardSection >> sectionTitle [
	^ 'Lcs book pages'
]
