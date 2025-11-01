Class {
	#name : #LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm,
	#superclass : #LcsMultislotPatternForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'mode',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm class >> builderClass [
	^ LcsGlobalCollectionWithDomainHavingALocalCollectionPatternBuilderJob
]

{ #category : #magritte }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> buildUnknownClassDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Build Unknown Class';
		priority: 3;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder buildUnknownClass));
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #'gt  views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps Tree';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtConstructionTreeFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView forward
		title: 'Refactoring';
		priority: 99.2;
		object: [  self slotModelBuilder ];
		view: #gtRefactoringChangeOn:
]

{ #category : #'gt  views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> gtSlotBuilderFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Raw';
		priority: 99.6;
		object: [  self slotModelBuilder ];
		view: #gtRawFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> gtSlotBuilderMetaFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Meta';
		priority: 99.7;
		object: [  self slotModelBuilder ];
		view: #gtMetaFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> gtUMLFor: aView [
	<gtView>
	^ aView forward
		title: 'UML';
		priority: 99;
		object: [  self slotModelBuilder ];
		view: #gtUMLFor:
]

{ #category : #initialize }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]

{ #category : #magritte }
LcsGlobalCollectionWithDomainHavingALocalCollectionPatternForm >> targetDomainClassesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Target Domain Classes';
		priority: 10;
		"accessor: (MAChainAccessor accessors: #(slotModelBuilder targetDomainClasses));"
		accessor: (LcsMAPluggableAccessor 
						accessors: #(#slotModelBuilder targetDomainClasses)
						read: [ :classes | classes collect: [ :each | each name] ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asClass ] ) ]);
		default: #(  );
		classes: { String. Symbol };
		beModifiable;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (
			self
				taggerStencilWithCompletion: GtClassesCompletionStrategy new
				andContextMenuBlock: nil);
		addCondition: [ :aValue | 
				aValue allSatisfy: [ :eachClassName | 
					eachClassName isClass or: [(Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'Duplicate classes are not allowed'

]
