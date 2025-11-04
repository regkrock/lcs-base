Class {
	#name : #LcsSingletonValueCollectionPatternForm,
	#superclass : #LcsMultislotPatternForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsSingletonValueCollectionPatternForm class >> builderClass [
	^ LcsSingletonValueObjectClassesBuilderJob
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
