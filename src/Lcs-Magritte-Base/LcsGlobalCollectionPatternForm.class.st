Class {
	#name : #LcsGlobalCollectionPatternForm,
	#superclass : #LcsBaseSlotCreationForm,
	#instVars : [
		'packageAndTagName',
		'onElementCreated',
		'mode',
		'slotClassName'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> buildUnknownClassDescription [
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

{ #category : #configuration }
LcsGlobalCollectionPatternForm >> builderClass [
	^ LcsDomainClassAndGlobalCollectionClassBuilderJob
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> classNamePrefixDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Name Prefix';
		priority: 1;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classPrefix));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> classRootNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Root Name';
		priority: 2;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder classRootName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 3 ] labelled: 'Enter a unique class prefix name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isCharacter ] ] labelled: 'Slot Names can contain only alphas';
		beRequired
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> domainInstanceSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Domain Slot Name';
		priority: 11;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder domainInstanceSlotName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps Tree';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtConstructionTreeFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView forward
		title: 'Refactoring';
		priority: 99.2;
		object: [  self slotModelBuilder ];
		view: #gtRefactoringChangeOn:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtSlotBuilderFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Raw';
		priority: 99.6;
		object: [  self slotModelBuilder ];
		view: #gtRawFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtSlotBuilderMetaFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder Meta';
		priority: 99.7;
		object: [  self slotModelBuilder ];
		view: #gtMetaFor:
]

{ #category : #'gt  views' }
LcsGlobalCollectionPatternForm >> gtUMLFor: aView [
	<gtView>
	^ aView forward
		title: 'UML';
		priority: 99;
		object: [  self slotModelBuilder ];
		view: #gtUMLFor:
]

{ #category : #initialize }
LcsGlobalCollectionPatternForm >> initializeOn: aTarget [
	super initializeOn: aTarget.
	self slotModelBuilder collectionSlotInstallationTargetClass: self targetClass.

]

{ #category : #testing }
LcsGlobalCollectionPatternForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = LcsDomainClassAndGlobalCollectionClassBuilderJob
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> targetDomainClassesDescription [
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

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> targetPackageNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package';
		priority: 8;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder targetPackageName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #magritte }
LcsGlobalCollectionPatternForm >> targetPackageTagNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package Tag';
		priority: 9;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder targetPackageTagName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]
