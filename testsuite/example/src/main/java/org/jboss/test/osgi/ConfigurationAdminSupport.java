/*
 * JBoss, Home of Professional Open Source
 * Copyright 2005, JBoss Inc., and individual contributors as indicated
 * by the @authors tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of
 * the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, write to the Free
 * Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA, or see the FSF site: http://www.fsf.org.
 */
package org.jboss.test.osgi;

import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleException;
import org.osgi.framework.ServiceReference;
import org.osgi.service.cm.ConfigurationAdmin;

/**
 * Provide the org.apache.felix.configadmin bundle
 *
 * @author thomas.diesler@jboss.com
 * @since 22-Oct-2012
 */
public class ConfigurationAdminSupport extends RepositorySupport {

    public static final String CONFIGURATION_ADMIN_SERVICE = "org.osgi.service.cm.ConfigurationAdmin";
    public static final String APACHE_FELIX_CONFIGURATION_ADMIN = "org.apache.felix:org.apache.felix.configadmin";

    public static void provideConfigurationAdmin(BundleContext syscontext, Bundle bundle) throws BundleException {
        ServiceReference sref = syscontext.getServiceReference(CONFIGURATION_ADMIN_SERVICE);
        if (sref == null) {
            installSupportBundle(syscontext, getCoordinates(bundle, APACHE_FELIX_CONFIGURATION_ADMIN)).start();
        }
    }

    public static ConfigurationAdmin getConfigurationAdmin(Bundle bundle) {
        BundleContext context = bundle.getBundleContext();
        ServiceReference sref = context.getServiceReference(ConfigurationAdmin.class.getName());
        return (ConfigurationAdmin) context.getService(sref);
    }
}