Class {
	#name : #LcsSingletonValueCollectionPatternForm,
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
LcsSingletonValueCollectionPatternForm class >> builderClass [
	^ LcsSingletonValueObjectClassesBuilderJob
]

{ #category : #'gt views' }
LcsSingletonValueCollectionPatternForm >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps Tree';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtConstructionTreeFor:
]

{ #category : #'gt views' }
LcsSingletonValueCollectionPatternForm >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView forward
		title: 'Refactoring';
		priority: 99.2;
		object: [  self slotModelBuilder ];
		view: #gtRefactoringChangeOn:
]

{ #category : #'gt views' }
LcsSingletonValueCollectionPatternForm >> gtSlotBuilderFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Raw';
		priority: 99.6;
		object: [  self slotModelBuilder ];
		view: #gtRawFor:
]

{ #category : #'gt views' }
LcsSingletonValueCollectionPatternForm >> gtSlotBuilderMetaFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Meta';
		priority: 99.7;
		object: [  self slotModelBuilder ];
		view: #gtMetaFor:
]

{ #category : #'gt views' }
LcsSingletonValueCollectionPatternForm >> gtUMLFor: aView [
	<gtView>
	^ aView forward
		title: 'UML';
		priority: 99;
		object: [  self slotModelBuilder ];
		view: #gtUMLFor:
]

{ #category : #initialize }
LcsSingletonValueCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass
]

{ #category : #magritte }
LcsSingletonValueCollectionPatternForm >> subclassRootNamesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Subclass Root Names';
		priority: 10;
		"accessor: (MAChainAccessor accessors: #(#slotModelBuilder #subclassRootNames));"
		accessor: (LcsMAPluggableAccessor 
				accessors: #(#slotModelBuilder #valueObjectSubclassBuilders)
				read: [ :subclassBuilders | subclassBuilders collect: [ :each | each rootName] ] 
				write: [ :aModel :setter :collection | | builders |
					builders := collection collect: [ :eachRootName | aModel valueObjectSubclassBuilderFor: eachRootName ].
					aModel perform: setter asSymbol with: builders ]);

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
				aValue allSatisfy: [ :eachClassRootName | 
					(Smalltalk classOrTraitNamed: self slotModelBuilder classPrefix asString , eachClassRootName asString trim) isNil ] ] 
			labelled: 'Class already exists';
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'Duplicate classes are not allowed'

]
