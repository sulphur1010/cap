(function() {
        // Load plugin specific language pack
        tinymce.PluginManager.requireLangPack('accordion');

        tinymce.create('tinymce.plugins.AccordionPlugin', {
                /**
                 * Initializes the plugin, this will be executed after the plugin has been created.
                 * This call is done before the editor instance has finished it's initialization so use the onInit event
                 * of the editor instance to intercept that event.
                 *
                 * @param {tinymce.Editor} ed Editor instance that the plugin is initialized in.
                 * @param {string} url Absolute URL to where the plugin is located.
                 */
                init : function(ed, url) {
                        // Register the command so that it can be invoked by using tinyMCE.activeEditor.execCommand('mceAccordion');
                        ed.addCommand('mceAccordion', function() {
																var dom = ed.dom;
																var sel = ed.selection;
																var list = dom.getParent(sel.getNode(), 'ul');
																var css_class = "accordion_list";

																function hasFormat(node) {
																	var state = true;
																	if (ed.dom.hasClass(css_class)) {
																		state = false;
																		return false;
																	}
																	return state;
																};

																if (!list || list.nodeName == 'UL' || hasFormat(list)) {
																	ed.execCommand('InsertUnorderedList');
																}

																list = dom.getParent(sel.getNode(), 'ul');
																if (list) {
																	dom.addClass(list, css_class);
																}

																ed.focus();
                        });

                        // Register accordion button
                        ed.addButton('accordion', {
                                title : 'Accordion List',
                                cmd : 'mceAccordion',
                                image : url + '/images/accordion.jpg'
                        });

                        // Add a node change handler, selects the button in the UI when a image is selected
                        ed.onNodeChange.add(function(ed, cm, n) {
                                cm.setActive('accordion', n.nodeName == 'IMG');
                        });
                },

                /**
                 * Creates control instances based in the incomming name. This method is normally not
                 * needed since the addButton method of the tinymce.Editor class is a more easy way of adding buttons
                 * but you sometimes need to create more complex controls like listboxes, split buttons etc then this
                 * method can be used to create those.
                 *
                 * @param {String} n Name of the control to create.
                 * @param {tinymce.ControlManager} cm Control manager to use inorder to create new control.
                 * @return {tinymce.ui.Control} New control instance or null if no control was created.
                 */
                createControl : function(n, cm) {
                        return null;
                },

                /**
                 * Returns information about the plugin as a name/value array.
                 * The current keys are longname, author, authorurl, infourl and version.
                 *
                 * @return {Object} Name/value array containing information about the plugin.
                 */
                getInfo : function() {
                        return {
                                longname : 'Accordion Menu System',
                                author : 'Matthew Tidd',
                                authorurl : 'http://www.dmtprogramming.com',
                                infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/accordion',
                                version : "1.0"
                        };
                }
        });

        // Register plugin
        tinymce.PluginManager.add('accordion', tinymce.plugins.AccordionPlugin);
})();
