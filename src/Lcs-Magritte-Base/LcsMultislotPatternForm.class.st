Class {
	#name : #LcsMultislotPatternForm,
	#superclass : #LcsBaseSlotCreationForm,
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #'as yet unclassified' }
LcsMultislotPatternForm class >> builderClass [
	self subclassResponsibility
]

{ #category : #configuration }
LcsMultislotPatternForm >> builderClass [
	^ self class builderClass
]

{ #category : #magritte }
LcsMultislotPatternForm >> classNamePrefixDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Name Prefix';
		priority: 2;
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
LcsMultislotPatternForm >> classRootNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class Root Name';
		priority: 3;
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
LcsMultislotPatternForm >> domainInstanceSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Domain Slot Name';
		priority: 11;
		accessor: (MAChainAccessor accessors: #(slotModelBuilder domainInstanceSlotName));
		default: '';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		comment: 'Use this name rather than the ''standard'' slot name. Example: #mainAddress rather than #address'
]

{ #category : #testing }
LcsMultislotPatternForm >> isSlotModelBuilderNotReified [
	^ self slotModelBuilder class = self builderClass
]

{ #category : #magritte }
LcsMultislotPatternForm >> targetDomainClassesDescription [
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
LcsMultislotPatternForm >> targetPackageNameDescription [
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
LcsMultislotPatternForm >> targetPackageTagNameDescription [
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
