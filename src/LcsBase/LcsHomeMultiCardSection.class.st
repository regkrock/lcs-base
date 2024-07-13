Class {
	#name : #LcsHomeMultiCardSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #LcsBase
}

{ #category : #accessing }
LcsHomeMultiCardSection >> gtBookCardSection [
	<gtExample>
	<notest>
	^ self
]

{ #category : #accessing }
LcsHomeMultiCardSection >> gtBookName [
	^ 'Lcs Book'
]

{ #category : #accessing }
LcsHomeMultiCardSection >> gtUsedKnowledgeBaseCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	^ GtHomeCard lcsLepiterBaseWithTableOfContents
		title: 'LCS Knowledge Base';
		description: 'Explore your LCS knowledge base';
		priority: 1;
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
LcsHomeMultiCardSection >> sectionTitle [
	^ 'Start'
]
