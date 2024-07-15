Class {
	#name : #LcsHomeMultiCardSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #LcsBase
}

{ #category : #accessing }
LcsHomeMultiCardSection >> aboutThisBookCard [
	"<gtSectionCard>"
	<gtExample>
	<notest>
	^ GtHomeCard page
		priority: 20;
		pageName: 'About this book';
		databaseName: self gtBookName;
		yourself
]

{ #category : #accessing }
LcsHomeMultiCardSection >> defaultPriority [
	^ 5
]

{ #category : #accessing }
LcsHomeMultiCardSection >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	^ self homeCard  
		title: 'LCS Knowledge Base';
		description: 'Explore your LCS knowledge base';
		priority: 5;
		primaryKnowledgebase;
		recentlyEditedPage;
		editableToolbar;
		details: [ :db | 
			| snippets somePages |
			somePages := db pages select: #shouldAppearInIndexOrDailyNotes.
			snippets := somePages flatCollect: #allChildrenDepthFirst.
			'Your LCS knowledge base includes '
				, somePages size asString , ' pages containing '
				, snippets size asString , ' snippets of '
				, (snippets groupedBy: #class) size asString , ' different kinds.' ]
				yourself
]

{ #category : #accessing }
LcsHomeMultiCardSection >> gtBookCardSection [
	<gtExample>
	<notest>
	^ self
]

{ #category : #accessing }
LcsHomeMultiCardSection >> gtBookName [
	^ 'LCS Knowledge Base'
]

{ #category : #accessing }
LcsHomeMultiCardSection >> homeCard [
	^ GtHomeLepiterBaseCard "GtHomePageCard" new
		databaseName: 'regkrock/lcs-base/lepiter';
		yourself
]

{ #category : #accessing }
LcsHomeMultiCardSection >> sectionTitle [
	^ 'Start'
]
